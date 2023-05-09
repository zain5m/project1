import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/home_layout/cubit/home_layout_cubit.dart';
import 'package:project1/models/comment_model.dart';
import 'package:project1/module/edit_post/edit_post_screen.dart';
import 'package:project1/module/home_post/cubit/home_post_cubit.dart';
import 'package:project1/module/show_post/cubit/show_post_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

Widget settingsCommentBottomsheet({
  required context,
  required String? postId,
  required CommentModel? comment,
  required int? index,
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

        // BlocConsumer<ShowPostCubit, ShowPostStates>(
        //   listener: (context, state) {},
        //   builder: (context, state) {
        //     ShowPostCubit cubit = ShowPostCubit.get(context);
        //     return
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                TextEditingController controller =
                    TextEditingController(text: comment!.content);
                return AlertDialog(
                  title: Text("Edit your coment"),
                  content: TextFormField(
                    controller: controller,
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: defaultColor),
                          ),
                        ),
                        BlocConsumer<ShowPostCubit, ShowPostStates>(
                          listener: (context, state) {
                            if (state is UpdateCommentSuccessState) {
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            ShowPostCubit cubit = ShowPostCubit.get(context);
                            return TextButton(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  cubit.updateComment(
                                    content: controller.text,
                                    commentId: comment.commentId!,
                                    postId: postId!,
                                    index: index!,
                                  );
                                }
                              },
                              child: Text(
                                "Update",
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
          // );
          // },
        ),
        // ),
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
                  title: Text("Delete your coment"),
                  content: Text("Are you sure?"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: defaultColor),
                          ),
                        ),
                        BlocConsumer<ShowPostCubit, ShowPostStates>(
                          listener: (context, state) {
                            if (state is DeletCommentSuccessState) {
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            ShowPostCubit cubit = ShowPostCubit.get(context);
                            return TextButton(
                              onPressed: () {
                                cubit.deletComment(
                                  commentId: comment!.commentId,
                                  postId: postId,
                                  index: index,
                                );
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
