import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/models/explore_model.dart';
import 'package:project1/module/show_post/cubit/show_post_cubit.dart';
import 'package:project1/module/show_post/show_post_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/network/remote/end_points.dart';

Widget buildPostExploreItem({
  required ExploreModel cubit,
  required BoxConstraints constraints,
  required bool isSmall,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      ShowPostCubit.get(context).getShowPost(
        postId: cubit.post!.postId,
      );
      navigateTo(
        context,
        ShowPostScreen(
          postId: cubit.post!.postId,
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.all(5),
      height:
          isSmall ? constraints.maxHeight / 4.5 : constraints.maxHeight / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black12,
        image: DecorationImage(
          image: NetworkImage(
            '$HOST/$POSTIMAGE/${cubit.post!.photo!}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
