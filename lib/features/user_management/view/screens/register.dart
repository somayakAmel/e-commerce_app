import 'package:e_commerce/features/user_management/view_model/auth_cubits/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';

import '../../../../utils/buttons.dart';
import '../../../../utils/cache_helper.dart';
import '../../../../utils/inputs.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/toast.dart';
import '../../../../utils/validator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var passwordController = TextEditingController();

    var confirmPasswordController = TextEditingController();

    var emailController = TextEditingController();

    var firstNameController = TextEditingController();

    var lastNameController = TextEditingController();

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showToast(context, "Register Success ", ToastificationType.success);
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.main,
            // arguments: index, // Pass the product ID as an argument
          );
        } else if (state is RegisterFailure) {
          showToast(context, state.message, ToastificationType.error);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: RegisterCubit.get(context).loadingState,
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          child: Scaffold(
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64.0),
                      const Text(
                        "Welcome",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "We are excited to have you Join us",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 16, height: 1.5, color: Colors.black54),
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: buildTextField(
                            onChanged: (p0) {},
                            controller: firstNameController,
                            icon: Icons.person,
                            label: "First Name",
                            validator: (Validator.nameValidator),
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: buildTextField(
                            onChanged: (p0) {},
                            controller: lastNameController,
                            icon: Icons.person,
                            label: "Last Name",
                            validator: (Validator.nameValidator),
                          )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: buildEmailField(
                          controller: emailController,
                          validator: (Validator.emailValidator),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: buildPasswordField(
                            label: 'password',
                            showPassword:
                                RegisterCubit.get(context).isPasswordVisible,
                            controller: passwordController,
                            validator: (Validator.passwordValidator),
                            changePasswordVisibility: () =>
                                RegisterCubit.get(context)
                                    .changePasswordVisibility()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: buildPasswordField(
                            label: 'confirm password',
                            showPassword:
                                RegisterCubit.get(context).isPasswordVisible,
                            controller: confirmPasswordController,
                            validator: (value) => Validator.rePasswordValidator(
                                value, passwordController.text),
                            changePasswordVisibility: () =>
                                RegisterCubit.get(context)
                                    .changePasswordVisibility()),
                      ),
                      const SizedBox(height: 16),
                      buildSubmitButton(
                        label: " Register ",
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        bgColor: Colors.black,
                        widthFactor: .5,
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {
                            RegisterCubit.get(context).userRegister(
                              emailController.text,
                              passwordController.text,
                              firstNameController.text,
                              lastNameController.text,
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
                              "Or register with",
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
                            var value = await RegisterCubit.get(context)
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("have an account?"),
                          buildTextButton(
                              label: "Login",
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
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
