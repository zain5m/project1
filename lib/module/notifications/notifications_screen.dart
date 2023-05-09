import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:iconify_flutter/icons/clarity.dart';
import 'package:project1/layout/profile/cubit/profile_cubit.dart';
import 'package:project1/layout/profile/profile_screen.dart';
import 'package:project1/models/Notifications/notifications_model.dart';
import 'package:project1/models/extensions/date_time_extension.dart';
import 'package:project1/module/notifications/cubit/notifications_cubit.dart';
import 'package:project1/module/show_post/cubit/show_post_cubit.dart';
import 'package:project1/module/show_post/show_post_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => NotificationsCubit()..getNotifications(),
      child: BlocConsumer<NotificationsCubit, NotificationsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NotificationsCubit cubit = NotificationsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 5,
              title: Text(
                'Notifications',
              ),
              actions: [
                cubit.notifications != null
                    ? cubit.notifications!.unRead != 0
                        ? IconButton(
                            onPressed: () {
                              cubit.markAsRead();
                            },
                            icon: Iconify(
                              Ci.notification_dot,
                              color: defaultColor,
                              size: 26,
                            ),
                          )
                        : IconButton(
                            onPressed: () {},
                            icon: Iconify(
                              Ci.notification,
                              color: defaultColor,
                              size: 26,
                            ),
                          )
                    : SizedBox(),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: cubit.notifications != null
                  ? ListView.builder(
                      itemBuilder: (context, index) => buildnotificationsItem(
                        not: cubit.notifications!.notifications![index],
                        isNotRead:
                            cubit.notifications!.notifications![index].readAt ==
                                null,
                        context: context,
                        cubit: cubit,
                        // onTap: () {
                        //   cubit.notificationsRead(
                        //     idNot:
                        //         cubit.notifications!.notifications![index].id,
                        //     type: cubit
                        //         .notifications!.notifications![index].type,
                        //     userId: cubit.notifications!.notifications![index]
                        //         .data!.userId,
                        //     postId: cubit.notifications!.notifications![index]
                        //         .data!.postId,
                        //   );
                        // }
                      ),
                      // separatorBuilder: (context, index) => Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 8),
                      //   child: Divider(
                      //     color: Colors.grey,
                      //     thickness: 1,
                      //     height: getProportionateScreenHeight(5),
                      //   ),
                      // ),
                      itemCount: cubit.notifications!.notifications!.length,
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

Widget buildnotificationsItem({
  required Notifications not,
  required bool isNotRead,
  required BuildContext context,
  required NotificationsCubit cubit,
  // void Function()? onTap,
}) {
  return GestureDetector(
    onTap: () {
      if (isNotRead) {
        cubit.notificationsRead(
          idNot: not.id,
          type: not.type,
          userId: not.data!.userId,
          postId: not.data!.postId,
        );
      }

      switch (not.type) {
        case "App\\Notifications\\FollowNotification":
          navigateTo(
            context,
            ProfileScreen(
              userId: not.data!.userId,
            ),
          );
          break;
        default:
          {
            ShowPostCubit.get(context).getShowPost(
              postId: not.data!.postId,
            );
            navigateTo(
              context,
              ShowPostScreen(
                postId: not.data!.postId,
              ),
            );
          }
      }
    },
    child: Container(
      color: isNotRead ? defaultColor.withOpacity(0.5) : Colors.white,
      padding: EdgeInsets.all(getProportionateScreenHeight(15)),
      child: Row(
        children: [
          not.data!.userPhoto != null
              ? CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    "$HOST/$USERIMAGE/${not.data!.userPhoto}",
                  ),
                )
              : CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    USERIMAGENULL,
                  ),
                ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                start: getProportionateScreenWidth(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  not.data!.message!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Text(
                  not.createdAt!.timeAgo(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: isNotRead ? Colors.white60 : textColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          CircleAvatar(
            radius: isNotRead ? 5 : 0,
          ),
        ],
        // onTap: () {
        //   if (isNotRead) {
        //     cubit.notificationsRead(
        //       idNot: not.id,
        //       type: not.type,
        //       userId: not.data!.userId,
        //       postId: not.data!.postId,
        //     );
        //   }

        //   switch (not.type) {
        //     case "App\\Notifications\\FollowNotification":
        //       navigateTo(
        //         context,
        //         ProfileScreen(
        //           userId: not.data!.userId,
        //         ),
        //       );
        //       break;
        //     default:
        //       {
        //         ShowPostCubit.get(context).getShowPost(
        //           postId: not.data!.postId,
        //         );
        //         navigateTo(
        //           context,
        //           ShowPostScreen(
        //             postId: not.data!.postId,
        //           ),
        //         );
        //       }
        //   }
        // },
        // leading: not.data!.userPhoto != null
        //     ? CircleAvatar(
        //         backgroundImage: NetworkImage(
        //           "$HOST/$USERIMAGE/${not.data!.userPhoto}",
        //         ),
        //       )
        //     : CircleAvatar(
        //         backgroundImage: AssetImage(
        //           USERIMAGENULL,
        //         ),
        //       ),
        // title: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       not.data!.message!,
        //       overflow: TextOverflow.ellipsis,
        //       maxLines: 2,
        //     ),
        //     Text(
        //       not.createdAt!.timeAgo(),
        //       overflow: TextOverflow.ellipsis,
        //       maxLines: 1,
        //       style: TextStyle(
        //         color: textColor,
        //         fontSize: 12,
        //       ),
        //     ),
        //   ],
        // ),
        // selected: isNotRead,
        // selectedColor: Colors.red,
        // trailing: CircleAvatar(
        //   radius: isNotRead ? 5 : 0,
        // ),
      ),
    ),
  );
}
