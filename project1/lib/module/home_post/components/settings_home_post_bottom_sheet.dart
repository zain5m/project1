import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/home_layout/cubit/home_layout_cubit.dart';
import 'package:project1/models/home_post/home_post_model.dart';
import 'package:project1/models/post_model.dart';
import 'package:project1/module/edit_post/edit_post_screen.dart';
import 'package:project1/module/home_post/cubit/home_post_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

Widget settingsHomePostBottomsheet({
  required context,
  required String? postId,
  required int? index,
  required PostModel post,
}) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          color: defaultColor,
          thickness: 4,
          height: getProportionateScreenHeight(20),
          indent: MediaQuery.of(context).size.width / 2 - 30,
          endIndent: MediaQuery.of(context).size.width / 2 - 30,
        ),
        ListTile(
          leading: Icon(
            IconBroken.Edit,
            color: defaultColor,
            size: 30,
          ),
          title: Text(
            'Edit',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            navigateTo(
              context,
              EditPostScreen(
                index: index!,
                post: post,
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.delete_outline_rounded,
            color: Colors.red,
            size: 30,
          ),
          title: Text(
            'Delete',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Delete your Post"),
                  content: Text("Are you sure?"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
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

                        BlocConsumer<HomePostCubit, HomePostStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            HomePostCubit cubit = HomePostCubit.get(context);
                            return TextButton(
                              onPressed: () {
                                cubit.deletePost(
                                  index: index,
                                  postId: postId,
                                );

                                Navigator.pop(context);
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: defaultColor,
                                ),
                              ),
                            );
                          },
                        ),
                        // ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
