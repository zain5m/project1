import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/models/extensions/date_time_extension.dart';
import 'package:project1/models/chat/user_message_model.dart';
import 'package:project1/module/chat/chat_details_screen.dart';
import 'package:project1/module/chat/cubit/social_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myphoto = MyProfileLayoutCubit.get(context)
        .myProfileData!
        .myInfo!
        .personal!
        .photo;
    String myEmail = MyProfileLayoutCubit.get(context)
        .myProfileData!
        .myInfo!
        .personal!
        .email!;
    return Scaffold(
      appBar: AppBar(
        leading: myphoto != null
            ? Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                child: CircleAvatar(
                  radius: 5,
                  backgroundImage: NetworkImage('$HOST/$USERIMAGE/$myphoto'),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                child: CircleAvatar(
                  backgroundImage: AssetImage(USERIMAGENULL),
                ),
              ),
        elevation: 3,
        title: Text(
          'Chat',
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chat_Room')
            .where(
              "user",
              arrayContains: CacheHelper.getData(key: USERID),
            )
            .orderBy('dateTimeLastMessage')
            .snapshots(),
        builder: (context, usersReceiver) {
          return !usersReceiver.hasData
              ? Center(
                  child: Text('NO USER'),
                )
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<dynamic> users =
                        usersReceiver.data!.docs.elementAt(index).get('user');
                    var user = users.where((element) =>
                        element != CacheHelper.getData(key: USERID));
                    return StreamBuilder<
                        DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.first.toString())
                          .snapshots(),
                      builder: (context, snapshot) {
                        log(snapshot.data.toString());
                        if (snapshot.hasData) {
                          UserMessageModel user = UserMessageModel.fromJson(
                            snapshot.data!.data()!,
                            usersReceiver.data!.docs[index].data(),
                          );

                          return buildChatItem(
                            context: context,
                            id: usersReceiver.data!.docs[index].id,
                            index: index,
                            user: user,
                            snapshot1: snapshot,
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    indent: 1,
                  ),
                  itemCount: usersReceiver.data!.docs.length,
                );
        },
      ),
    );
  }
}

Widget buildChatItem({
  required UserMessageModel user,
  required context,
  required int index,
  required String id,
  required AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot1,
}) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('chat_Room')
          .doc(id)
          .collection('messages')
          .where("isRead", isEqualTo: false)
          .where('receiverId', isEqualTo: CacheHelper.getData(key: USERID))
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox();
        } else {
          int massagesIsNotRead = snapshot.data!.docs.length;
          return InkWell(
            onTap: () {
              navigateTo(
                context,
                ChatDetailsScreen(
                  snapshot: snapshot1,
                  receiverId: user.userId!,
                  senderId: CacheHelper.getData(key: USERID),
                  roomId: id,
                  user: user,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    clipBehavior: Clip.hardEdge,
                    children: [
                      user.userPhoto != null
                          ? CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  '$HOST/$USERIMAGE/${user.userPhoto}'),
                            )
                          : const CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(USERIMAGENULL),
                            ),
                      user.isOnline!
                          ? CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.green,
                            )
                          : CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.grey,
                            ),
                    ],
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(15),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.userName!,
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 19,
                            height: 1.4,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              user.lastMessageModel!.lastMessage!.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: massagesIsNotRead > 0
                                    ? defaultColor
                                    : textColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          // 'ss',
                          user.lastMessageModel!.dateTimeLastMessage!
                              .formatTimeINAMPM,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            height: 1.4,
                            color: massagesIsNotRead > 0
                                ? defaultColor
                                : textColor,
                          ),
                        ),
                        if (massagesIsNotRead > 0)
                          CircleAvatar(
                            radius: 10,
                            child: Text(
                              massagesIsNotRead.toString(),
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 11,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
}
