import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/models/chat/user_message_model.dart';
import 'package:project1/models/extensions/date_time_extension.dart';
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
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myphoto = MyProfileLayoutCubit.get(context)
        .myProfileData!
        .myInfo!
        .personal!
        .photo;
    return Scaffold(
      appBar: AppBar(
        leading: myphoto != null
            ? Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                child: CircleAvatar(
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
      body: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.get(context);

          return cubit.userReseverModel!.isNotEmpty
              ? ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildChatItem(
                    cubit.userReseverModel![index],
                    context,
                    index,
                  ),
                  separatorBuilder: (context, index) => Divider(
                    indent: 1,
                  ),
                  itemCount: cubit.userReseverModel!.length,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

Widget buildChatItem(UserMessageModel model, context, int index) => InkWell(
      onTap: () {
        navigateTo(
          context,
          ChatDetailsScreen(
            receiverId: model.userId,
            senderId: CacheHelper.getData(key: USERID),
            receiverName: model.userName,
            receiverPhoto: model.userPhoto,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            model.userPhoto != null
                ? CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage('$HOST/$USERIMAGE/${model.userPhoto}'),
                  )
                : CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(USERIMAGENULL),
                  ),
            SizedBox(
              width: getProportionateScreenWidth(15),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.userName!,
                    style: TextStyle(
                      fontSize: 19,
                      height: 1.4,
                    ),
                  ),
                  Text(
                    model.lastMessage!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: textColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    model.dateTimeLastMessage!, //.timeAgo(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      height: 1.4,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
