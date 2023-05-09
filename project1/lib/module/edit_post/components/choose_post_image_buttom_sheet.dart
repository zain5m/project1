import 'package:flutter/material.dart';
import 'package:project1/module/add_post/cubit/add_post_cubit.dart';

import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';

Widget choosePostImageButtomSheet({
  required AddPostCubit cubit,
  required BuildContext context,
}) {
  SizeConfig().init(context);
  return Container(
    height: getProportionateScreenHeight(110),
    width: SizeConfig.screenWidth,
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Text(
          "Choose Photo",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                // cubit.getAddImage(source: ImageSource.camera);
              },
              icon: Icon(
                Icons.camera,
                color: defaultColor,
                size: 30,
              ),
              label: Text(
                "Camera",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                // cubit.getAddImage(source: ImageSource.gallery);
              },
              icon: Icon(
                Icons.image,
                color: defaultColor,
                size: 30,
              ),
              label: Text(
                "Gallery",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
