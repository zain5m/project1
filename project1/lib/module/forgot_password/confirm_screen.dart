import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/module/forgot_password/components/defalt_pin.dart';
import 'package:project1/module/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:project1/module/forgot_password/new_password.dart';
import 'package:project1/module/forgot_password/reset_password_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';

class ConfirmScreen extends StatefulWidget {
  String? email;
  ConfirmScreen({
    required this.email,
  });
  @override
  State<ConfirmScreen> createState() => ConfirmScreenState();
}

class ConfirmScreenState extends State<ConfirmScreen> {
  var formkey = GlobalKey<FormState>();
  FocusNode? pin2FocusNode;

  FocusNode? pin3FocusNode;

  FocusNode? pin4FocusNode;

  FocusNode? pin5FocusNode;

  var pin1Controller = TextEditingController();

  var pin2Controller = TextEditingController();

  var pin3Controller = TextEditingController();

  var pin4Controller = TextEditingController();

  var pin5Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin5FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final String? censuredEmail;
    if (widget.email!.lastIndexOf('@') == 2) {
      censuredEmail = widget.email!
          .replaceRange(1, widget.email.toString().indexOf("@"), '*');
    } else {
      censuredEmail = widget.email.toString().replaceRange(
          2,
          widget.email.toString().indexOf("@"),
          '*' * (widget.email!.lastIndexOf('@') - 2));
    }
    // var result =
    //     args.toString().replaceAll(RegExp('(?<=.)[^@](?=[^@]*?[^@]@)'), '*');
    // print(args.toString().substring(0, 2));
    // final z1 =
    //     args.toString().replaceRange(2, args.toString().indexOf("@"), '*');
    // print(z1);

    // final censuredEmail = args.toString().substring(0, 2) +
    //     '*' * 2 +
    //     args.toString().substring(args.toString().indexOf("@"));
    // print(censuredEmail);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(34),
              vertical: getProportionateScreenHeight(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "confirm your account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(17),
                ),
                Text(
                  "Enter the code we sent to \n$censuredEmail", //touka.*********.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(29),
                ),
                Text(
                  "we sent a 5-digit code to your email address\nEnter that code to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(28),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaltPin(
                      controller: pin1Controller,
                      onchanged: (value) {
                        nextField(value, pin2FocusNode);
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    defaltPin(
                      controller: pin2Controller,
                      focusnode: pin2FocusNode,
                      onchanged: (value) {
                        nextField(value, pin3FocusNode);
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    defaltPin(
                      controller: pin3Controller,
                      focusnode: pin3FocusNode,
                      onchanged: (value) {
                        nextField(value, pin4FocusNode);
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    defaltPin(
                      controller: pin4Controller,
                      focusnode: pin4FocusNode,
                      onchanged: (value) {
                        nextField(value, pin5FocusNode);
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(5)),
                    defaltPin(
                      controller: pin5Controller,
                      focusnode: pin5FocusNode,
                      onchanged: (value) {
                        if (value.length == 1) {
                          pin5FocusNode!.unfocus();
                          // Then you need to check is the code is correct or not
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(38),
                ),
                BlocProvider(
                  create: (context) => ForgotPasswordCubit(),
                  child:
                      BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
                    listener: (context, state) {
                      if (state is ComfirmCodeSucssesState) {
                        if (state.sucsses == "Code is uncorrect") {
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
                              NewPasswordScreen(
                                email: widget.email,
                              ));
                        }
                      }
                    },
                    builder: (context, state) {
                      ForgotPasswordCubit cubit =
                          ForgotPasswordCubit.get(context);
                      return defaultButton(
                        text: 'Continue',
                        function: () {
                          String code = pin1Controller.text +
                              pin2Controller.text +
                              pin3Controller.text +
                              pin4Controller.text +
                              pin5Controller.text;
                          cubit.comfirmCode(
                            email: widget.email!,
                            code: code,
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(90),
                  child: TextButton.icon(
                    onPressed: () {
                      navigateAndReplac(context, ResetPasswordScreen());
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 30,
                      color: defaultColor,
                    ),
                    label: const Text(
                      "Send Email again",
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
