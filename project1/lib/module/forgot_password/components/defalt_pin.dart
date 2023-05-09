import 'package:flutter/material.dart';

Widget defaltPin({
  required TextEditingController? controller,
  required Function(String)? onchanged,
  FocusNode? focusnode,
}) =>
    Expanded(
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          autofocus: true,
          focusNode: focusnode,
          controller: controller,
          style: TextStyle(
            fontSize: 37,
            height: 0.8,
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            hintText: '*',
            hintStyle: TextStyle(
              color: Color(0xffb6b7b7),
              fontSize: 37,
              height: 1.6,
            ),
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: onchanged,
        ),
      ),
    );
