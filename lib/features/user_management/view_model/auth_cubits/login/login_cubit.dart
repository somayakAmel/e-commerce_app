import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../utils/cache_helper.dart';
import '../../../model/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(UserLoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  late UserModel user;
  bool loadingState = false;
  void userLogin(String email, String password) async {
    emit(LoginLoading());
    changeLoadingState();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      saveUser(value.user!.uid);
      loadingState = false;
      emit(LoginSuccess(value.user!.uid));
      changeLoadingState();
    }).catchError((e) {
      changeLoadingState();

      Validator.firebaseLoginValidator(e);
    });
  }

  void saveUser(String uId) {
    CacheHelper.saveData(key: "uId", value: uId);
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      user = UserModel.fromJson(value.data()!);
    });
  }

  signOut() async {
    try {
      emit(SignOutLoading());
      await FirebaseAuth.instance.signOut();
      CacheHelper.removeData(key: "uId");
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure());
    }
  }

  bool isPasswordVisible = false;

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginChangePasswordVisibility());
  }

  void changeLoadingState() {
    loadingState = !loadingState;
  }
}
