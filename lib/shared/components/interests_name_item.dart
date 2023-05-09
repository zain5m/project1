import 'package:flutter/material.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';

Widget interestsNameItem(String name) {
  return Padding(
    padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
    child: Row(
      children: [
        Text(
          "#",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: defaultColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: defaultColor,
          ),
        ),
      ],
    ),
  );
}
