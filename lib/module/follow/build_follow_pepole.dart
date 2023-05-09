import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:project1/layout/app_layout/app_layout.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/layout/profile/profile_screen.dart';
import 'package:project1/models/follow_model.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';

Widget buildFollowPepole({
  required FollowAndBlockModel? person,
  required BuildContext context,
}) {
  var myUserId = CacheHelper.getData(key: USERID);

  return Row(
    children: [
      Flexible(
        child: ListTile(
          onTap: () {
            AppLayoutCubit cubit = AppLayoutCubit.get(context);
            if (person!.userId == myUserId) {
              // cubit.changeBottomNav(3);
              navigateTo(
                context,
                // AppLayout(),
                MyProfileLayout(),
              );
            } else {
              navigateTo(
                context,
                ProfileScreen(
                  userId: person.userId,
                ),
              );
            }
          },
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment(0.5, 0),
                end: Alignment(0.5, 1),
                colors: [defaultColor, defaultColor],
              ),
              border: Border.all(
                color: Colors.transparent,
                width: 3,
              ),
            ),
            child: person!.photo != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      '$HOST/$USERIMAGE/${person.photo}',
                    ),
                    radius: 28,
                  )
                : CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ),
                    radius: 28,
                  ),
          ),
          title: Text(
            person.name!,
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
        child: IconButton(
          onPressed: () {},
          icon: Iconify(
            Ph.chat_circle_dots,
            size: 25,
            color: defaultColor,
          ),
        ),
      ),
    ],
  );
}
