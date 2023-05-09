import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:project1/models/explore_model.dart';
import 'package:project1/models/home_post/home_post_model.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/module/comments/components/components.dart';
import 'package:project1/module/edit_post/edit_post_screen.dart';
import 'package:project1/module/home_post/home_post_screen.dart';
import 'package:project1/models/extensions/date_time_extension.dart';
import 'package:project1/module/show_post/cubit/show_post_cubit.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/network/remote/pusher_service.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';
import 'package:project1/tes/ne/add_post.dart';
import 'package:readmore/readmore.dart';

PusherService pusherService = PusherService();

class CommentsScreeen extends StatelessWidget {
  CommentsScreeen({
    this.postId,
  });
  String? postId;
  LaravelFlutterPusher pusher =
      pusherService.initPusher("12345", "$Hos!", 6001, "mt1");
  @override
  Widget build(BuildContext context) {
    var commentControler = TextEditingController();
    pusherService.listen(
        pusher, 'Post$postId', "App\\Events\\CommentEvent", context);
    return BlocConsumer<ShowPostCubit, ShowPostStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShowPostCubit cubit = ShowPostCubit.get(context);
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.96,
          builder: (context, scrollController) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: state is ShowPostLoadingState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                          end: getProportionateScreenWidth(15),
                          top: getProportionateScreenHeight(15),
                        ),
                        height: getProportionateScreenHeight(60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            reactPost(
                              size: getProportionateScreenWidth(2),
                              color: cubit.data!.post!.react == "Upvoted"
                                  ? defaultColor
                                  : textColor,
                              onTap: () {
                                // cubit.upvot(postId: cubit.data!.post!.postId, index: index!);
                              },
                              icon: Ph.arrow_fat_lines_up_thin, //Bx.upvote,
                              numberOfREact: cubit.data!.post!.upVotesNumber!,
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(15),
                            ),
                            reactPost(
                              color: cubit.data!.post!.react == "Downvoted"
                                  ? defaultColor
                                  : textColor,
                              onTap: () {},
                              icon:
                                  Ph.arrow_fat_lines_down_thin, // Bx.downvote,
                              numberOfREact: cubit.data!.post!.downVotesNumber!,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey[300],
                      ),
                      state is ShowPostLoadingState
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                reverse: true,
                                itemBuilder: (context, index) =>
                                    buildCommentItem(
                                  index: index,
                                  postId: postId!,
                                  context: context,
                                  coment: cubit.data!.comments![index],
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                    height: getProportionateScreenHeight(5)),
                                itemCount: cubit.data!.comments!.length,
                              ),
                            ),
                      Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey[300],
                      ),
                      Material(
                        color: Colors.white,
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Container(
                            padding:
                                EdgeInsets.all(getProportionateScreenHeight(8)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: commentControler,
                                    autofocus: true,
                                    minLines: 1,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      fillColor: Colors.black.withOpacity(0.1),
                                      isDense: true,
                                      filled: true,
                                      hintText: 'Write comment ...',
                                      hintStyle: const TextStyle(
                                        height: 0.7,
                                        fontSize: 15,
                                      ),
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
                                    if (commentControler.text.isNotEmpty) {
                                      cubit.sendComment(
                                        postId: postId,
                                        comment:
                                            commentControler.text.toString(),
                                      );
                                      commentControler.clear();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    }
                                  },
                                  icon: const Icon(
                                    IconBroken.Send,
                                    size: 30,
                                    color: defaultColor,
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
      },
    );
    // );
  }
}
