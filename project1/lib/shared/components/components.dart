import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:path/path.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

// !!!!!!!!!!!!!!!!!!!!!

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndReplac(
  context,
  widget,
) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

// !!!!!!!!!!!!

Widget alertDialog({
  required String title,
  required BuildContext context,
  required void Function()? onPressed,
}) =>
    AlertDialog(
      title: Text(title),
      content: Text("Are you sure?"),
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 24.0, 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: defaultColor,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "OK",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: defaultColor,
            ),
          ),
        ),
      ],
    );

// !!!!!!!!!!!!!!!!!!!!!!!!
Widget defaultButton({
  isIcf = false,
  String? icf,
  double width = double.infinity,
  Color backgroundcolor = defaultColor,
  Color textcolor = Colors.white,
  double radius = 28.0,
  double fontSize = 19.0,
  List<BoxShadow>? boxShadow,
  Gradient? gradient,
  FontWeight? fontWeight = FontWeight.w600,
  required Function()? function,
  String? text,
  IconData? icon,
  Color borderColor = defaultColor,
  bool isBorderColor = true,
}) =>
    InkWell(
      onTap: function,
      child: Container(
        width: width,
        height: getProportionateScreenHeight(50),
        decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(radius),
          color: backgroundcolor,
          border: isBorderColor ? Border.all(color: borderColor) : null,
        ),
        child: Center(
          child: text != null
              ? Text(
                  text,
                  style: TextStyle(
                    fontWeight: fontWeight,
                    color: textcolor,
                    fontSize: fontSize,
                  ),
                )
              : isIcf
                  ? Iconify(
                      icf!,
                      color: Colors.white,
                    )
                  : Icon(
                      icon,
                      color: Colors.white,
                      size: 25,
                    ),
        ),
      ),
    );

void nextField(FocusNode? focusNode) {
  focusNode!.requestFocus();
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validate,
  required String label,
  String? hintText,
  double radius = 28,
  bool? filled = true,
  Color? fillColor = formFieldColor,
  IconData? prefix,
  Function()? suffixPressed,
  IconData? suffix,
  Function(String)? onChanged,
  Function(String)? onSubmit,
  Function()? onTap,
  bool isbasswors = false,
  bool isClickable = true,
  bool readOnly = false,
  FocusNode? focusnode,
}) =>
    TextFormField(
      focusNode: focusnode,
      readOnly: readOnly,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      controller: controller,
      keyboardType: type,
      obscureText: isbasswors,
      cursorColor: defaultColor,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: filled,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintFieldColor,
          fontWeight: FontWeight.w400,
          fontSize: 15.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );

Widget defaultDropFormField({
  required String? label,
  required List? list,
  required void Function(Object?)? onchanged,
  FloatingLabelAlignment? floatingLabelAlignment =
      FloatingLabelAlignment.center,
  String? Function(Object?)? validate,
  IconData? suffix,
  FocusNode? focusnode,
}) {
  return DropdownButtonFormField(
    focusNode: focusnode,
    menuMaxHeight: getProportionateScreenHeight(250),
    borderRadius: BorderRadius.circular(30),
    dropdownColor: formFieldColor,
    validator: validate,
    onChanged: onchanged,
    decoration: InputDecoration(
      fillColor: formFieldColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      labelText: label,
      isDense: true,
      suffixIcon: suffix != null ? Icon(suffix) : null,
    ),
    items: list!.map((list) {
      return DropdownMenuItem(
        child: Text(list),
        value: list,
      );
    }).toList(),
  );
}

// !!!!!!!!!!!!!!
SnackBar validatorSnackBarInterests({String? text, ToastState? state}) =>
    SnackBar(
      content: Text(
        text!,
        textAlign: TextAlign.center,
      ),
      backgroundColor: chooseToastColor(
        state,
      ),
      duration: Duration(seconds: 5),
    );

Widget showToastCustem({required ToastState state, required String text}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      color: chooseToastColor(state),
      child: Text(text),
    );

// !
void showToastShap({
  required String text,
  required ToastState state,
  required BuildContext context,
}) {
  FToast? fToast = FToast().init(context);

  fToast.showToast(
    child: showToastCustem(state: state, text: text),
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: 2),
  );
}

void showToast({
  required String text,
  required ToastState state,
  ToastGravity gravity = ToastGravity.CENTER,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastState { SUCCESS, ERROR, WORNING }

Color chooseToastColor(ToastState? state) {
  Color color;
  switch (state!) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WORNING:
      color = Colors.amber;
      break;
  }
  return color;
}
