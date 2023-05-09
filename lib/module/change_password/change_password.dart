import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/layout/home_layout/home_layout.dart';
import 'package:project1/module/change_password/cubit/change_password_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';

class ChangePasswordScreen extends StatelessWidget {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var newConfirmPasswordController = TextEditingController();
  FocusNode? pinNewPasswordFocusNode = FocusNode();
  FocusNode? pinNewConfirmPasswordFocusNode = FocusNode();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
        listener: (context, state) {
          if (state is ChangePasswordErrorState) {
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if (state is ChangePasswordSuccessState) {
            showToast(
              text: state.success,
              state: ToastState.SUCCESS,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          ChangePasswordCubit cubit = ChangePasswordCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                  color: Colors.black,
                ),
                title: Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(34),
                          vertical: getProportionateScreenHeight(48),
                        ),
                        child: Column(
                          children: [
                            defaultFormField(
                              onSubmit: (value) {
                                nextField(pinNewPasswordFocusNode);
                              },
                              controller: oldPasswordController,
                              type: TextInputType.visiblePassword,
                              label: 'Old Password',
                              hintText: "Enter your old Password",
                              suffix: cubit.suffixOldPassword,
                              isbasswors: cubit.isOldPassword,
                              suffixPressed: () {
                                cubit.changeOldPasswordVisibility();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'pless enter your old password';
                                }
                                if (value.length < 8) {
                                  return 'It mustIt must contain at least 8 characters';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: getProportionateScreenHeight(28)),
                            defaultFormField(
                              focusnode: pinNewPasswordFocusNode,
                              onSubmit: (value) {
                                nextField(pinNewConfirmPasswordFocusNode);
                              },
                              controller: newPasswordController,
                              type: TextInputType.visiblePassword,
                              label: 'New Password',
                              hintText: "Enter your new Password",
                              suffix: cubit.suffixNewPassword,
                              isbasswors: cubit.isNewPassword,
                              suffixPressed: () {
                                cubit.changeNewPasswordVisibility();
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
                            SizedBox(height: getProportionateScreenHeight(28)),
                            defaultFormField(
                              focusnode: pinNewConfirmPasswordFocusNode,
                              controller: newConfirmPasswordController,
                              type: TextInputType.visiblePassword,
                              label: 'confirm Password',
                              hintText: "Enter your Password again",
                              suffix: cubit.suffixNewConfirm,
                              isbasswors: cubit.isNewConfirmPassword,
                              suffixPressed: () {
                                cubit.changeNewConfirmPasswordVisibility();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'pless enter your password';
                                }
                                if (value.length < 8) {
                                  return 'It mustIt must contain at least 8 characters';
                                }
                                if (newPasswordController.text !=
                                    newConfirmPasswordController.text) {
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
                                  cubit.changepassword(
                                    oldPassword: oldPasswordController.text,
                                    newPassword: newPasswordController.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Image(
                        image: AssetImage("assets/images/reset-password.png"),
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
