import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/models/chat/message_model.dart';
import 'package:project1/models/chat/user_message_model.dart';
import 'package:project1/module/chat/cubit/social_cubit.dart';
import 'package:project1/module/chat/components/message_item.dart';
import 'package:project1/models/extensions/date_time_extension.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

// String chatRoomId(String user1, String user2) {
//   if (user1.toLowerCase().codeUnits[0] > user2[0].toLowerCase().codeUnits[0]) {
//     return "$user1,$user2";
//   } else {
//     return "$user2,$user1";
//   }
// }

class ChatDetailsScreen extends StatelessWidget {
  int receiverId;
  int senderId;
  String roomId;
  UserMessageModel user;
  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot;
  ChatDetailsScreen({
    required this.snapshot,
    required this.receiverId,
    required this.senderId,
    required this.roomId,
    required this.user,
  });

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print(snapshot.data!.docs.first.data());
    // String myEmail = MyProfileLayoutCubit.get(context)
    //     .myProfileData!
    //     .myInfo!
    //     .personal!
    //     .email!;
    // String roomId = chatRoomId(myEmail, receiverEmail!);

    int myId = CacheHelper.getData(key: USERID);
    SizeConfig().init(context);
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            // backgroundColor: Color(0xfff0f1f5),
            body: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 5),
                        blurRadius: 30,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(flex: 1),
                        Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              clipBehavior: Clip.hardEdge,
                              children: [
                                user.userPhoto != null
                                    ? CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            '$HOST/$USERIMAGE/${user.userPhoto}'),
                                      )
                                    : CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            AssetImage(USERIMAGENULL),
                                      ),
                                user.isOnline!
                                    ? CircleAvatar(
                                        radius: 7,
                                        backgroundColor: Colors.green,
                                      )
                                    : CircleAvatar(
                                        radius: 7,
                                        backgroundColor: Colors.grey,
                                      ),
                              ],
                            ),
                            Text(
                              user.userName!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 25.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chat_Room')
                      .doc(roomId)
                      .collection('messages')
                      .orderBy('dateTime')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Flexible(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Flexible(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          physics: BouncingScrollPhysics(),
                          reverse: true,
                          itemBuilder: (context, index) {
                            final messages =
                                snapshot.data!.docs.reversed.elementAt(index);
                            MessageModel message =
                                MessageModel.fromJson(messages);
                            if (myId == message.senderId) {
                              return buildMyMessage(
                                model: message,
                                context: context,
                              );
                            } else {
                              return buildMessage(
                                model: message,
                                context: context,
                                image: user.userPhoto,
                              );
                            }
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount: snapshot.data!.docs.length,
                        ),
                      );
                    }
                  },
                ),
                Material(
                  color: Colors.transparent,
                  elevation: 10,
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10),
                      vertical: getProportionateScreenHeight(10),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            minLines: 1,
                            maxLines: 4,
                            controller: messageController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              isDense: true,
                              hintText: 'Type a message....',
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              SocialCubit.get(context).sendMessage(
                                roomId: roomId,
                                receiverId: receiverId,
                                senderId: senderId,
                                dateTime: Timestamp.now(),
                                text: messageController.text,
                              );

                              messageController.clear();
                            }
                          },
                          icon: Icon(
                            IconBroken.Send,
                            size: 25,
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    // });
  }
}

buildMessage({
  required MessageModel model,
  required String? image,
  required BuildContext context,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // image != null
      //     ? CircleAvatar(
      //         backgroundImage: NetworkImage("$HOST/$USERIMAGE/$image"),
      //         radius: 18,
      //       )
      //     : CircleAvatar(
      //         backgroundImage: AssetImage(USERIMAGENULL),
      //         radius: 18,
      //       ),
      // SizedBox(
      //   width: getProportionateScreenWidth(8),
      // ),
      Flexible(
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: EdgeInsetsDirectional.only(
            bottom: getProportionateScreenHeight(5),
            top: getProportionateScreenHeight(5),
            end: getProportionateScreenWidth(5),
            start: getProportionateScreenWidth(10),
          ),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                model.text!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(4)),
              Text(
                model.dateTime!.formatTimeINAMPM,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: SizeConfig.screenWidth / 4,
      ),
    ],
  );
}

buildMyMessage({
  required MessageModel model,
  required context,
}) {
  String image =
      MyProfileLayoutCubit.get(context).myProfileData!.myInfo!.personal!.photo!;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: SizeConfig.screenWidth / 4,
      ),
      Flexible(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff434b56).withOpacity(0.819),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: EdgeInsetsDirectional.only(
            bottom: getProportionateScreenHeight(5),
            top: getProportionateScreenHeight(5),
            end: getProportionateScreenWidth(5),
            start: getProportionateScreenWidth(10),
          ),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                model.text!,
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              SizedBox(width: getProportionateScreenWidth(4)),
              Text(
                model.dateTime!.formatTimeINAMPM,
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(width: getProportionateScreenWidth(4)),
              Iconify(
                model.isRead! ? Bi.check_all : Bi.check,
                color: model.isRead! ? defaultColor : Colors.white,
                size: 15,
              ),
            ],
          ),
        ),
      ),
      // SizedBox(
      //   width: getProportionateScreenWidth(8),
      // ),
      // image != null
      //     ? CircleAvatar(
      //         backgroundImage: NetworkImage("$HOST/$USERIMAGE/$image"),
      //         radius: 20,
      //       )
      //     : CircleAvatar(
      //         backgroundImage: AssetImage(USERIMAGENULL),
      //         radius: 20,
      //       ),
    ],
  );
}
