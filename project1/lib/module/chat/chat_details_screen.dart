import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/models/chat/message_model.dart';
import 'package:project1/module/chat/cubit/social_cubit.dart';
import 'package:project1/module/chat/components/message_item.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  var messageController = TextEditingController();
  int? receiverId;
  int? senderId;
  String? receiverPhoto;
  String? receiverName;
  // int? senderId;
  // int? senderId;
  ChatDetailsScreen({
    required this.receiverId,
    required this.senderId,
    required this.receiverName,
    required this.receiverPhoto,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // return Builder(builder: (context) {
    // SocialCubit.get(context).getMessages(
    //   receiverId: receiverId,
    //   senderId: senderId,
    // );
    // SocialCubit.get(context).getUserResver(
    //   receiverId: receiverId,
    // );

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
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
                        Spacer(
                          flex: 1,
                        ),
                        Column(
                          children: [
                            receiverPhoto != null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "$HOST/$USERIMAGE/$receiverPhoto"),
                                    radius: 30,
                                  )
                                : CircleAvatar(
                                    backgroundImage: AssetImage(
                                      USERIMAGENULL,
                                    ),
                                    radius: 30,
                                  ),
                            Text(
                              receiverName!,
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
                      .collection('user_chats')
                      .doc(senderId.toString())
                      .collection('chats')
                      .doc(receiverId.toString())
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
                            // var message = SocialCubit.get(context).messages[index];
                            //TODO: Put Current user
                            // if (senderId == message.senderId)
                            if (senderId == message.senderId) {
                              // snapshot.data!.docs[index].get('senderId')) {
                              return buildMyMessage(
                                model: message,
                                context: context,
                              );
                            } else {
                              return buildMessage(
                                model: message,
                                image: receiverPhoto,
                              );
                            }
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          // itemCount: SocialCubit.get(context).messages.length,
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
                                receiverId: receiverId,
                                senderId: senderId,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                                senderName: MyProfileLayoutCubit.get(context)
                                    .myProfileData!
                                    .myInfo!
                                    .personal!
                                    .name!,
                                senderPhoto: MyProfileLayoutCubit.get(context)
                                            .myProfileData!
                                            .myInfo!
                                            .personal!
                                            .photo !=
                                        null
                                    ? MyProfileLayoutCubit.get(context)
                                        .myProfileData!
                                        .myInfo!
                                        .personal!
                                        .photo!
                                    : null,
                                receiverName: receiverName!,
                                receiverPhoto: receiverPhoto,
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
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      image != null
          ? CircleAvatar(
              backgroundImage: NetworkImage("$HOST/$USERIMAGE/$image"),
              radius: 20,
            )
          : CircleAvatar(
              backgroundImage: AssetImage(USERIMAGENULL),
              radius: 20,
            ),
      SizedBox(
        width: getProportionateScreenWidth(8),
      ),
      Flexible(
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            model.text!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
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
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Text(
            model.text!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      SizedBox(
        width: getProportionateScreenWidth(8),
      ),
      MyProfileLayoutCubit.get(context)
                  .myProfileData!
                  .myInfo!
                  .personal!
                  .photo !=
              null
          ? CircleAvatar(
              backgroundImage: NetworkImage(
                  "$HOST/$USERIMAGE/${MyProfileLayoutCubit.get(context).myProfileData!.myInfo!.personal!.photo}"),
              radius: 20,
            )
          : CircleAvatar(
              backgroundImage: AssetImage(USERIMAGENULL),
              radius: 20,
            ),
    ],
  );
}
