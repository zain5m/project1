import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:project1/models/comment_model.dart';
import 'package:project1/models/explore_model.dart';
import 'package:project1/module/show_post/settingsCommentBottomsheet.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';

Widget reactPost({
  required void Function()? onTap,
  required String icon,
  required int numberOfREact,
  double size = 8,
  double sizeicon = 28,
  required Color color,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Iconify(
          icon,
          size: sizeicon,
          color: color,
        ),
        SizedBox(
          width: getProportionateScreenWidth(size),
        ),
        Text(
          numberOfREact.toString(),
        ),
      ],
    ),
  );
}

Widget buildCommentItem({
  required BuildContext context,
  required CommentModel coment,
  required String postId,
  required int index,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: () {
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
                comment: coment,
                index: index,
              );
            },
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            coment.user!.photo != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      '$HOST/$USERIMAGE/${coment.user!.photo!}',
                    ),
                    radius: 22,
                  )
                : CircleAvatar(
                    backgroundImage: AssetImage(
                      USERIMAGENULL,
                    ),
                    radius: 22,
                  ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(.1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                    vertical: getProportionateScreenHeight(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coment.user!.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        coment.content!,
                        maxLines: double.infinity.hashCode,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
