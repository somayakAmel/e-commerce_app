import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      emit(LoginSuccess());
      changeLoadingState();
    }).catchError((e) {
      changeLoadingState();
      emit(LoginFailure(
        message: Validator.firebaseLoginValidator(e.code),
      ));
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

  // signInWithGoogle() async {
  //   try {
  //     final googleAccount = await signInWithGoogle();
  //     final googleAuth = await googleAccount?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     final userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     // user = UserModel(
  //     //   id: userCredential.user!.uid,
  //     //   email: userCredential.user!.email!,
  //     //   name: userCredential.user!.displayName!,
  //     // );
  //     // CacheHelper.saveData(key: "uId", value: userCredential.user!.uid);
  //     emit(LoginSuccess());
  //   } catch (e) {
  //     emit(LoginFailure(message: e.toString()));
  //   }
  // }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      emit(LoginSuccess());

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      emit(LoginFailure(message: e.toString()));
      return Future.error(e);
    }
  }
}
