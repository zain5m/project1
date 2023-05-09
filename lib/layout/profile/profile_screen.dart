import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/components/part_top_profile.dart';

import 'package:project1/layout/my_profile_layout/components/part_top_profile_sliver_app_bar.dart';
import 'package:project1/layout/my_profile_layout/components/sttings_bottom_shet.dart/custem_language_meun_shape_border.dart';
import 'package:project1/layout/my_profile_layout/components/sttings_bottom_shet.dart/language_item.dart';
import 'package:project1/layout/my_profile_layout/components/sttings_bottom_shet.dart/settings_bottom_sheet.dart';
import 'package:project1/layout/my_profile_layout/components/tab_bar_sliver_app_bar.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/layout/profile/components/menu_profile.dart';
import 'package:project1/layout/profile/cubit/profile_cubit.dart';
import 'package:project1/models/Language.dart';

import 'package:project1/module/profile_post/profile_post_sceen.dart';
import 'package:project1/module/profile_prometed/profile_prometed_screen.dart';
import 'package:project1/shared/components/components.dart';

import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/routes/routes.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  int? userId;
  ProfileScreen({
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ScrollController scrollController = ScrollController();
    GlobalKey keyForBack = GlobalKey();
    return BlocProvider(
      create: (context) => ProfileCubit()
        ..getDataProfile(
          userId: userId,
        ),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileBlockUserErrorStates) {
            showToast(
              text: state.error,
              state: ToastState.ERROR,
            );
          }
          if (state is ProfileBlockUserSucssesStates) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return SafeArea(
            bottom: false,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      PartTopProfileSliverAppBar(
                        onPressed: () {
                          showMenu(
                            context: context,
                            position:
                                RelativeRect.fromLTRB(double.infinity, 0, 0, 0),
                            items: [
                              PopupMenuItem(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alertDialog(
                                          title: 'Block',
                                          context: context,
                                          onPressed: () {
                                            cubit.blockUser(
                                              userId: userId,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  leading: Icon(
                                    Icons.block,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    'Block',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        scrollController: scrollController,
                        keyForBack: keyForBack,
                        icon: Icons.more_vert_rounded,
                        background: state is ProfileGetDataLoadingStates
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : PartTopProfile(
                                context: context,
                                scrollController: scrollController,
                                userId: userId,
                                data: cubit.profileData!,
                                isMe: false,
                              ),
                      ),
                      TabBarSliverAppBar(
                        keyForBack: keyForBack,
                      ),
                    ];
                  },
                  controller: scrollController,
                  body: TabBarView(
                    children: [
                      state is ProfileGetDataLoadingStates
                          ? Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : PeofilePostScreen(
                              posts: cubit.profileData!.posts,
                            ),
                      state is ProfileGetDataLoadingStates
                          ? Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : ProfilePrometedScreen(
                              posts: cubit.profileData!.postsPrometed,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
