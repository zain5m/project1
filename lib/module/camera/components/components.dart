import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

Widget defaultSliverAppBarEndToGallery({
  required void Function()? onPressedIconButton,
  Widget? widgit,
  required cubit,
  required void Function(String?)? onChangedDropdownButton,
}) =>
    SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      forceElevated: true,
      elevation: 0.5,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(
            IconBroken.Camera,
            size: 30,
            color: defaultColor,
          ),
          onPressed: onPressedIconButton,
        ),
        if (widgit != null) widgit,
        SizedBox(
          width: 10,
        ),
      ],
      titleSpacing: 0,
      title: Row(
        children: [
          SizedBox(width: getProportionateScreenWidth(10)),
          DropdownButton<String>(
            value: cubit.currentdropdownValue,
            items:
                cubit.nameAlbums!.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChangedDropdownButton,
          ),
        ],
      ),
    );
Widget defaultSliverAppBarCenterToGallery({
  required GlobalKey keyForBack,
  required child,
}) =>
    SliverAppBar(
      floating: true,
      key: keyForBack,
      excludeHeaderSemantics: true,
      expandedHeight: getProportionateScreenHeight(350),
      forceElevated: true,
      elevation: 0.5,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.all(15),
          child: child,
        ),
      ),
    );
Widget defaultSliverAppBarTopToGallery({
  required String? title,
  required void Function()? onPressedTextButton,
  required context,
  required cubit,
  String next = "NEXT",
}) =>
    SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      forceElevated: true,
      elevation: 0.5,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        title!,
        style: TextStyle(
          fontSize: 18,
          color: welcomColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              defaultColor.withOpacity(0.1),
            ),
          ),
          onPressed: cubit.currentImage == null
              ? () {
                  showToast(
                    text: 'It must contain an image',
                    state: ToastState.ERROR,
                    gravity: ToastGravity.CENTER,
                  );
                }
              : onPressedTextButton,
          child: Text(
            next,
            style: TextStyle(
              color: defaultColor,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
