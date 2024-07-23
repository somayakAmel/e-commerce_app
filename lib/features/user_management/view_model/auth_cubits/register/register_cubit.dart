import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/user_management/model/user.dart';
import 'package:e_commerce/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/cache_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(UserRegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  late UserModel user;
  bool loadingState = false;
  void userRegister(
    String email,
    String password,
    String fName,
    String lName,
  ) async {
    changeLoadingState();

    emit(RegisterLoading());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate('$fName $lName', email, value.user!.uid);
    }).catchError((e) {
      changeLoadingState();

      Validator.firebaseRegisterValidator(e);
    });
  }

  userCreate(String name, String email, String uId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(uId).set({
      "name": name,
      "email": email,
      "uId": uId,
    }).then((value) {
      saveUser(uId, email, name);
      changeLoadingState();

      emit(RegisterSuccess());
    }).catchError((error) {
      emit(CreateFailure(message: error));
    });
  }

  void saveUser(String uId, String email, String name) {
    CacheHelper.saveData(key: "uId", value: uId);
    user = UserModel(id: uId, email: email, name: name);
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
    emit(RegisterChangePasswordVisibility());
  }

  void changeLoadingState() {
    loadingState = !loadingState;
  }

  bool passwordSimilar = true;

  void checkPasswordSimilarity(String password, String confirmPassword) {
    if (password == confirmPassword) {
      passwordSimilar = true;
    } else {
      passwordSimilar = false;
    }
  }
}
