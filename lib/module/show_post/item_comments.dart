import 'package:flutter/material.dart';
import 'package:project1/models/comment_model.dart';
import 'package:project1/models/explore_model.dart';
import 'package:project1/module/show_post/cubit/show_post_cubit.dart';
import 'package:project1/module/show_post/settingsCommentBottomsheet.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';

Widget buidCommentsItem({
  required CommentModel? comment,
  required context,
  required postId,
  required int? index,
}) =>
    InkWell(
      onLongPress: comment!.userId == CacheHelper.getData(key: USERID)
          ? () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return settingsCommentBottomsheet(
                    context: context,
                    postId: postId,
                    comment: comment,
                    index: index,
                  );
                },
              );
            }
          : () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          comment.user!.photo != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                  "$HOST/$USERIMAGE/${comment.user!.photo!}",
                ))
              : CircleAvatar(
                  backgroundImage: AssetImage(
                    USERIMAGENULL,
                  ),
                  radius: 22,
                ),
          SizedBox(
            width: getProportionateScreenWidth(8),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.user!.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Text(
                  comment.content!,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
