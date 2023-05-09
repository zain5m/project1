import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/shared/components/size_config.dart';

Widget defultProgileDropdownButton({
  required String hint,
  required String? valueChoose,
  bool isExpanded = false,
  required List list,
  required void Function(Object?)? onChanged,
  required String? Function(Object?)? validate,
}) =>
    DropdownButtonFormField(
      validator: validate,
      hint: Text(hint),
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 28,
      isExpanded: isExpanded,
      menuMaxHeight: getProportionateScreenHeight(250),
      isDense: true,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 20.0,
      ),
      value: valueChoose,
      onChanged: onChanged,
      items: list.map((valueItem) {
        return DropdownMenuItem(
          value: valueItem,
          child: Text(
            valueItem,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
    );
Widget defaultFormFeild({
  required TextEditingController controller,
  required var label,
  required IconData prefix,
  IconData? suffix,
  bool? isMax = false,
  required String? Function(String?)? validate,
}) =>
    isMax!
        ? TextFormField(
            validator: validate,
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(prefix),
            ),
          )
        : TextFormField(
            validator: validate,
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(prefix),
            ),
          );
