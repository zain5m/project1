import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/components/part_top_profile.dart';

import 'package:project1/layout/my_profile_layout/components/part_top_profile_sliver_app_bar.dart';
import 'package:project1/layout/my_profile_layout/components/sttings_bottom_shet.dart/settings_bottom_sheet.dart';
import 'package:project1/layout/my_profile_layout/components/tab_bar_sliver_app_bar.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';

import 'package:project1/module/profile_post/profile_post_sceen.dart';
import 'package:project1/module/profile_prometed/profile_prometed_screen.dart';

import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/routes/routes.dart';
import 'package:project1/shared/styes/icon_broken.dart';

class MyProfileLayout extends StatelessWidget {
  static String routeName = "/profile_layout";

  @override
  Widget build(BuildContext context) {
    MyProfileLayoutCubit.get(context).getDataProfile();

    SizeConfig().init(context);
    ScrollController scrollController = ScrollController();
    GlobalKey keyForBack = GlobalKey();
    return
        // BlocProvider(
        //   create: (context) => MyProfileLayoutCubit()..getDataProfile(),
        // child:
        BlocConsumer<MyProfileLayoutCubit, MyProfileLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MyProfileLayoutCubit cubit = MyProfileLayoutCubit.get(context);
        return SafeArea(
          bottom: false,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    PartTopProfileSliverAppBar(
                      scrollController: scrollController,
                      keyForBack: keyForBack,
                      childBottomSheet: settingsBottomSheet(context),
                      icon: IconBroken.Setting,
                      background:
                          state is MyProfileLayoutGetDataProfileLoadingStates
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : PartTopProfile(
                                  context: context,
                                  scrollController: scrollController,
                                  data: cubit.myProfileData!,
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
                    state is MyProfileLayoutGetDataProfileLoadingStates
                        ? Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : PeofilePostScreen(
                            posts: cubit.myProfileData!.posts,
                          ),
                    state is MyProfileLayoutGetDataProfileLoadingStates
                        ? Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : ProfilePrometedScreen(
                            posts: cubit.myProfileData!.postsPrometed,
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      // ),
    );
  }
}

// class SliverPersistentHeaderDelegateImpl
//     extends SliverPersistentHeaderDelegate {
//   final TabBar? tabBar;
//   final TabController? tabController;
//   final Color? color;
//   SliverPersistentHeaderDelegateImpl({
//     Color color = Colors.transparent,
//     this.tabBar,
//     this.tabController,
//   }) : this.color = color;
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return // tabBar!;
//         //     SliverAppBar(
//         //   backgroundColor: Colors.transparent,
//         //   elevation: 0,
//         //   toolbarHeight: 15,
//         //   pinned: true,
//         //   bottom: TabBar(
//         //     indicatorColor: defaultColor,
//         //     indicatorSize: TabBarIndicatorSize.label,
//         //     labelColor: Colors.black,
//         //     unselectedLabelStyle: TextStyle(
//         //       fontSize: 20,
//         //       fontWeight: FontWeight.w500,
//         //     ),
//         //     labelStyle: TextStyle(
//         //       fontSize: 20,
//         //       fontWeight: FontWeight.w500,
//         //     ),
//         //     unselectedLabelColor: Color(0xff9f9f9f),
//         //     tabs: [
//         //       Tab(text: 'Post'),
//         //       Tab(text: 'Prometing'),
//         //     ],
//         //   ),
//         //   flexibleSpace: Container(
//         //     decoration: const BoxDecoration(
//         //       color: Colors.white,
//         //       borderRadius: BorderRadius.only(
//         //         bottomLeft: const Radius.circular(30),
//         //         bottomRight: const Radius.circular(30),
//         //       ),
//         //       boxShadow: [
//         //         BoxShadow(
//         //           color: const Color(0x29000000),
//         //           offset: const Offset(0, 5),
//         //           blurRadius: 30,
//         //           spreadRadius: 0,
//         //         )
//         //       ],
//         //     ),
//         //   ),
//         // );
//         Container(
//       margin: EdgeInsets.symmetric(horizontal: 50),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: tabBar,
//     );
//   }

//   @override
//   double get maxExtent => tabBar!.preferredSize.height;
//   @override
//   double get minExtent => tabBar!.preferredSize.height;
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
