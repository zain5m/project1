import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/models/register/list_model.dart';
import 'package:project1/models/user_data_model.dart';
import 'package:project1/module/add_photo/add_photo_register_screen.dart';
import 'package:project1/module/intersts/interests_screen.dart';
import 'package:project1/module/login/login_screen.dart';
import 'package:project1/module/register/cubit/register_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/styes/colors.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = "/register";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? genderController;
  String? dayController;
  String? monthController;
  String? yearController;

  // FocusNode? pinNameFocusNode = FocusNode();
  FocusNode? pinEmailFocusNode = FocusNode();
  FocusNode? pinPasswordFocusNode = FocusNode();
  FocusNode? pinConfirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            showToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
          if (state is RegisterSuccessState) {
            CacheHelper.saveData(key: TOKEN, value: state.user.token)
                .then((value) {
              CacheHelper.saveData(key: USERID, value: state.user.user!.id)
                  .then((value) {
                navigateTo(context, AddPhotoRegisterScreen());
              }).catchError((error) {
                showToast(
                  state: ToastState.WORNING,
                  text: error.message,
                );
              });
            }).catchError((error) {
              showToast(
                state: ToastState.WORNING,
                text: error.message,
              );
            });
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(34)),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(55)),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 32,
                          color: welcomColor,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Text(
                        "Add your details to sign up",
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(35)),
                      defaultFormField(
                        onSubmit: (value) {
                          nextField(pinEmailFocusNode);
                        },
                        controller: nameController,
                        type: TextInputType.name,
                        label: "Name",
                        hintText: "Enter your Name",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'pless enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(28)),
                      defaultFormField(
                        focusnode: pinEmailFocusNode,
                        onSubmit: (value) {
                          nextField(pinPasswordFocusNode);
                        },
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
                          if (!value.contains('.')) {
                            return 'It must contain the .';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(28)),
                      defaultFormField(
                        focusnode: pinPasswordFocusNode,
                        onSubmit: (value) {
                          nextField(pinConfirmPasswordFocusNode);
                        },
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        hintText: "Enter your Password",
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
                      SizedBox(height: getProportionateScreenHeight(28)),
                      defaultFormField(
                        focusnode: pinConfirmPasswordFocusNode,
                        controller: confirmPasswordController,
                        type: TextInputType.visiblePassword,
                        label: 'confirm Password',
                        hintText: "Enter your Password",
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
                            print(passwordController);
                            print(confirmPasswordController);
                            return 'password and confirm password does not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(21)),
                      defaultDropFormField(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        label: 'Gender',
                        validate: (value) {
                          if (value == null) {
                            return 'pless enter your gender';
                          }
                          return null;
                        },
                        list: genderList,
                        onchanged: (value) {
                          genderController = value.toString();
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(27)),
                      Row(
                        children: [
                          Flexible(
                            child: defaultDropFormField(
                              label: 'Day',
                              list: dayList,
                              onchanged: (value) {
                                dayController = value.toString();
                              },
                              validate: (value) {
                                if (value == null) {
                                  return 'pless enter your day';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          Flexible(
                            child: defaultDropFormField(
                              label: 'Month',
                              list: monthList,
                              onchanged: (value) {
                                monthController = value.toString();
                              },
                              validate: (value) {
                                if (value == null) {
                                  return 'pless enter your month';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          Flexible(
                            child: defaultDropFormField(
                              label: 'Year',
                              list: yearList,
                              onchanged: (value) {
                                yearController = value.toString();
                              },
                              validate: (value) {
                                if (value == null) {
                                  return 'pless enter your year';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(32)),
                      defaultButton(
                        text: "Sign Up",
                        function: () {
                          if (formKey.currentState!.validate()) {
                            // if (state is! RegisterLoadingState) {
                            cubit.userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                              gender: genderController == 'Male' ? 2 : 1,
                              date:
                                  "${yearController}/${monthController}/${dayController}",
                              fcm: 'sss', // CacheHelper.getData(key: FCM),
                            );
                            // }
                          }
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(26)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Aleady have an Account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                color: defaultColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
