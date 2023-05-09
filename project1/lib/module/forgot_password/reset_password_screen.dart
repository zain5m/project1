import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/module/forgot_password/confirm_screen.dart';
import 'package:project1/module/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';

class ResetPasswordScreen extends StatelessWidget {
  static String routeName = "/resetPassword";
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(34)),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(38)),
                  Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(12)),
                  Text(
                    "Please enter your email to receive a \ncode to create a new password via email",
                    style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getProportionateScreenHeight(60)),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: "Email",
                    hintText: "Enter your Email Address",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'pless enter your Email Address';
                      }
                      if (!value.contains('@')) {
                        return 'It must contain the @';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(38)),
                  BlocProvider(
                    create: (context) => ForgotPasswordCubit(),
                    child:
                        BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
                      listener: (context, state) {
                        if (state is RestPasswordSucssesState) {
                          if (state.sucsses == "Your email is uncorrect") {
                            showToast(
                              text: state.sucsses!,
                              state: ToastState.ERROR,
                            );
                          } else {
                            showToast(
                              text: state.sucsses!,
                              state: ToastState.SUCCESS,
                            );
                            navigateTo(
                              context,
                              ConfirmScreen(
                                email: emailController.text,
                              ),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        ForgotPasswordCubit cubit =
                            ForgotPasswordCubit.get(context);
                        return defaultButton(
                          text: 'Send',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.restPassword(
                                email: emailController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
