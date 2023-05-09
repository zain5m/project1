import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/module/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:project1/module/welcom/welcom_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';

import 'package:project1/layout/home_layout/home_layout.dart';

class NewPasswordScreen extends StatelessWidget {
  String? email;
  NewPasswordScreen({required this.email});
  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
        listener: (context, state) {
          if (state is NewPasswordSucssesState) {
            showToast(
              text: state.sucsses!,
              state: ToastState.SUCCESS,
            );
            AppLayoutCubit.get(context).changeBottomNav(0);
            navigateAndFinish(context, WelcomScreen());
          }
          if (state is NewPasswordErrorState) {
            showToast(
              text: state.error!,
              state: ToastState.ERROR,
            );
          }
        },
        builder: (context, state) {
          var cubit = ForgotPasswordCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(34)),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(height: getProportionateScreenHeight(50)),
                            Container(
                              child: Text(
                                "New Password",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(38)),
                            defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              label: 'New Password',
                              hintText: "Enter your new Password",
                              suffix: cubit.suffix,
                              isbasswors: cubit.isPassword,
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'pless enter your password';
                                }
                                if (value.length < 8) {
                                  return 'It mustIt must contain at least 8 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(24)),
                            defaultFormField(
                              controller: confirmPasswordController,
                              type: TextInputType.visiblePassword,
                              label: 'confirm Password',
                              hintText: "Enter your Password again",
                              suffix: cubit.suffixConfirm,
                              isbasswors: cubit.isPasswordConfirm,
                              suffixPressed: () {
                                cubit.changeConfirmPasswordVisibility();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'pless enter your password';
                                }
                                if (value.length < 8) {
                                  return 'It mustIt must contain at least 8 characters';
                                }
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  return 'password and confirm password does not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(38)),
                            defaultButton(
                              text: 'Next',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.newPassword(
                                    email: email!,
                                    password: passwordController.text,
                                    compassword: confirmPasswordController.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(66)),
                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(378),
                      child: Image(
                        image: AssetImage("assets/images/newpassword.png"),
                        //fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
