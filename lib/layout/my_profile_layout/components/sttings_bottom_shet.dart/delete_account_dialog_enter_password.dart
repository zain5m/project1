import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/shared/styes/colors.dart';

Widget deleteAccountDialogEnterPassword(context) =>
    BlocConsumer<MyProfileLayoutCubit, MyProfileLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MyProfileLayoutCubit cubit = MyProfileLayoutCubit.get(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text("Enter Your Password to continue"),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 24.0, 10.0),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          content: TextFormField(
            obscureText: cubit.isPassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(cubit.suffix, color: defaultColor),
                onPressed: () {
                  cubit.changePasswordVisibility();
                },
              ),
              hintText: "Enter your Password",
              hintStyle: TextStyle(
                color: hintFieldColor,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: defaultColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Send",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: defaultColor,
                ),
              ),
            ),
          ],
        );
      },
    );
