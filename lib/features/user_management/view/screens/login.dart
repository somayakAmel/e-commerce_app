import 'package:e_commerce/features/user_management/view_model/auth_cubits/login/login_cubit.dart';
import 'package:e_commerce/utils/cache_helper.dart';
import 'package:e_commerce/utils/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../utils/buttons.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/toast.dart';
import '../../../../utils/validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
        } else if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.main);
          showToast(context, "Login Success ", ToastificationType.success);

          // replacementNavigate(context, const HomeScreen());
        } else if (state is LoginFailure) {
          showToast(context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: LoginCubit.get(context).loadingState,
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          child: Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64.0),
                      const Text(
                        "Welcome Back",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "We are excited to have you back",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.black54),
                      ),
                      const SizedBox(height: 32.0),
                      buildEmailField(
                        controller: emailController,
                        validator: (Validator.emailValidator),
                      ),
                      const SizedBox(height: 16.0),
                      buildPasswordField(
                        label: 'password',
                        showPassword: LoginCubit.get(context).isPasswordVisible,
                        controller: passwordController,
                        validator: (Validator.passwordValidator),
                        changePasswordVisibility: () =>
                            LoginCubit.get(context).changePasswordVisibility(),
                      ),
                      const SizedBox(height: 16),
                      buildSubmitButton(
                        label: " Login ",
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        bgColor: Colors.black,
                        widthFactor: .5,
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {
                            LoginCubit.get(context).userLogin(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(
                            height: 4,
                            thickness: 2,
                          )),
                          SizedBox(height: 16),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Or Login with",
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            height: 4,
                            thickness: 2,
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: buildOptionButton(
                          src: 'google',
                          onTap: () async {
                            var value = await LoginCubit.get(context)
                                .signInWithGoogle();
                            var uId = value.user!.uid;
                            CacheHelper.saveData(key: "uId", value: uId);
                          },
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(height: 1.5),
                          children: [
                            TextSpan(
                              text: "By logging, you agree to our",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: " Terms & Conditions",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " \nand ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: "Privacy Policy.",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 64),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          buildTextButton(
                              label: "Register",
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.register,
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
