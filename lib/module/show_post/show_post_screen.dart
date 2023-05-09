// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/line_md.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/prime.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
// import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/module/comments/components/components.dart';
import 'package:project1/module/search/components/build_search_interest.dart';
import 'package:project1/module/show_post/cubit/show_post_cubit.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/network/remote/pusher_service.dart';
import 'package:project1/shared/routes/routes.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';
import 'package:project1/module/show_post/item_comments.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';

import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../shared/network/remote/pusher.dart';

PusherService pusherService = PusherService();

const String PUSHER_KEY = '12345';
const String PUSHER_CLUSTER = 'mt1';
String BEARER_TOKEN = CacheHelper.getData(key: TOKEN);
String AUTH_URL = 'http://192.168.1.104:8000/api/broadcasting/auth';

// PusherOptions options = PusherOptions(
//   cluster: PUSHER_CLUSTER,
//   host: '192.168.1.104',
//   encrypted: false,
//   auth: PusherAuth(
//     AUTH_URL,
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $BEARER_TOKEN',
//     },
//   ),
// );

// Create socket.io client
// IO.Socket socket = IO.io(
//   'http://192.168.1.104:6001',
//   IO.OptionBuilder().disableAutoConnect().setTransports(['websocket']).build(),
// );

// Create echo instance

class ShowPostScreen extends StatelessWidget {
// Create pusher client
  // PusherClient pusherClient = PusherClient(
  //   PUSHER_KEY,
  //   options,
  //   autoConnect: false,
  //   enableLogging: true,
  // );

  TextEditingController commentController = TextEditingController();

  ScrollController? controllerComments = ScrollController();
  LaravelFlutterPusher pusher =
      pusherService.initPusher("12345", '$Hos!', 6001, "mt1");
  String? postId;
  ShowPostScreen({
    required this.postId,
  });
  // var k = initPusherClient();
  @override
  Widget build(BuildContext context) {
// Create echo instance

    // Echo echo = new Echo(
    //   broadcaster: EchoBroadcasterType.Pusher,
    //   client: pusherClient,
    // );

// Listening public channel
    // echo.channel('Post$postId!').listen('App\\Events\\CommentEvent', (e) {
    //   print(e);
    // });

// Accessing pusher instance
    // echo.connector.pusher.onConnectionStateChange((state) {
    //   print(state!.currentState.toString());
    // });
    SizeConfig().init(context);
    print(postId);
    // pusherService.listen(
    //     pusher, 'Post$postId!', "App\\Events\\CommentEvent", context);

    return
        //  BlocProvider(
        // create: (context) => ShowPostCubit()..getShowPost(postId: postId),
        // child:
        BlocConsumer<ShowPostCubit, ShowPostStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShowPostCubit cubit = ShowPostCubit.get(context);

        return SafeArea(
          child: Scaffold(
            body: state is ShowPostLoadingState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      KeyboardVisibilityListener(
                        listener: (isKeyboardVisible) {
                          if (isKeyboardVisible) {
                            Future.delayed(Duration(milliseconds: 100), () {
                              controllerComments!.animateTo(
                                controllerComments!.position.maxScrollExtent,
                                curve: Curves.fastOutSlowIn,
                                duration: const Duration(milliseconds: 300),
                              );
                            });
                          }
                        },
                        child: Flexible(
                          fit: FlexFit.tight,
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.manual,
                            controller: controllerComments,
                            child: Column(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Image.network(
                                      "$HOST/$POSTIMAGE/${cubit.data!.post!.photo!}",
                                      fit: BoxFit.cover,
                                      height: SizeConfig.screenHeight / 1.7,
                                      width: double.infinity,
                                    ),
                                    Positioned(
                                      bottom: getProportionateScreenHeight(-60),
                                      left: getProportionateScreenWidth(20),
                                      child:
                                          cubit.data!.post!.user!.photo == null
                                              ? CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: AssetImage(
                                                    USERIMAGENULL,
                                                  ),
                                                )
                                              : CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: NetworkImage(
                                                    '$HOST/$USERIMAGE/${cubit.data!.post!.user!.photo!}',
                                                  ),
                                                ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(5)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          start:
                                              getProportionateScreenWidth(80),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              cubit.data!.post!.user!.name!,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            reactPost(
                                              sizeicon: 35,
                                              color: cubit.data!.post!.react ==
                                                      "Upvoted"
                                                  ? defaultColor
                                                  : textColor,
                                              onTap: () {
                                                cubit.upvot(postId: postId);
                                              },
                                              icon: Ph.arrow_fat_lines_up_thin,
                                              numberOfREact: cubit
                                                  .data!.post!.upVotesNumber!,
                                              size: 2,
                                            ),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                8,
                                              ),
                                            ),
                                            reactPost(
                                              sizeicon: 35,
                                              color: cubit.data!.post!.react ==
                                                      "Downvoted"
                                                  ? defaultColor
                                                  : textColor,
                                              onTap: () {
                                                cubit.downVot(postId: postId);
                                              },
                                              icon:
                                                  Ph.arrow_fat_lines_down_thin,
                                              numberOfREact: cubit
                                                  .data!.post!.downVotesNumber!,
                                              size: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Wrap(
                                        spacing:
                                            getProportionateScreenWidth(10),
                                        alignment: WrapAlignment.end,
                                        children: List.generate(
                                          cubit.data!.post!.interestId!.length,
                                          (index) {
                                            int indexInterest = cubit
                                                .data!.post!.interestId![index];
                                            return interstPost(
                                              context: context,
                                              indexInterest: indexInterest,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(10),
                                      ),
                                      Text(
                                        cubit.data!.post!.content!,
                                        style: TextStyle(
                                          // color: textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(10)),
                                      Text(
                                        "Comments :",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(10)),
                                      cubit.data!.comments!.isNotEmpty
                                          ? ListView.separated(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              reverse: true,
                                              itemBuilder: (context, index) {
                                                return buidCommentsItem(
                                                  index: index,
                                                  comment: cubit
                                                      .data!.comments![index],
                                                  context: context,
                                                  postId: postId,
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 20),
                                              itemCount:
                                                  cubit.data!.comments!.length,
                                            )
                                          : Center(
                                              child: Text(
                                                'There are no Comments. You can add the first Comment',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: textColor,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        elevation: 10,
                        child: Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenHeight(8)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: commentController,
                                  minLines: 1,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[200],
                                    isDense: true,
                                    // contentPadding: EdgeInsets.only(
                                    //     top: 4, bottom: 4, left: 6, right: 6),
                                    filled: true,
                                    hintText: 'Write comment ...',
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (commentController.text.isNotEmpty) {
                                    cubit.sendComment(
                                      postId: postId,
                                      comment:
                                          commentController.text.toString(),
                                    );
                                    commentController.clear();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    // MediaQuery.of(context).viewInsets.bottom
                                  }
                                },
                                icon: Icon(
                                  IconBroken.Send,
                                  size: 30,
                                  color: defaultColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   height: getProportionateScreenHeight(80),
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: getProportionateScreenWidth(8),
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Color(0x29000000),
                      //         offset: Offset(0, 5),
                      //         blurRadius: 30,
                      //       )
                      //     ],
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: 8,
                      //       ),

                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
          ),
        );
      },
      // ),
    );
  }
}

class KeyboardVisibilityListener extends StatefulWidget {
  final Widget child;
  final void Function(
    bool isKeyboardVisible,
  ) listener;

  const KeyboardVisibilityListener({
    Key? key,
    required this.child,
    required this.listener,
  }) : super(key: key);

  @override
  _KeyboardVisibilityListenerState createState() =>
      _KeyboardVisibilityListenerState();
}

class _KeyboardVisibilityListenerState extends State<KeyboardVisibilityListener>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      _isKeyboardVisible = newValue;
      widget.listener(_isKeyboardVisible);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
