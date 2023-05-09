import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/models/extensions/date_time_extension.dart';

class StoryUserInfo extends StatelessWidget {
  String? profileImageUrl;
  String? name;
  DateTime? creatAt;

  StoryUserInfo({
    required this.name,
    required this.profileImageUrl,
    required this.creatAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        profileImageUrl != null
            ? CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(
                  "$HOST/$USERIMAGE/${profileImageUrl!}",
                ),
                // CachedNetworkImageProvider(
                //   user.profileImageUrl,
                // ),
              )
            : CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage(
                  USERIMAGENULL,
                ),
                // CachedNetworkImageProvider(
                //   user.profileImageUrl,
                // ),
              ),
        SizedBox(width: getProportionateScreenWidth(10)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              creatAt!.timeAgoStory(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          icon: Iconify(
            Fluent.delete_16_regular,
            size: 25.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
