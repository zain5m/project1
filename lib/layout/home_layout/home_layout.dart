import 'package:flutter/material.dart';
import 'package:project1/layout/home_layout/components/part_top_home_sliver_app_bar.dart';
import 'package:project1/layout/home_layout/components/tab_bar_sliver_app_bar_home.dart';
import 'package:project1/module/explore/explore_screen.dart';
import 'package:project1/module/home_post/home_post_screen.dart';

class HomeLayout extends StatelessWidget {
  static String routeName = "/HomeLayout";

// TabController s=TabController(length: 2,vsync: this);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SafeArea(
        bottom: false,
        // maintainBottomViewPadding: true,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            // extendBody: true,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  PartTopHomeSliverAppBar(),
                  TabBarSliverAppBarHome(),
                ];
              },
              body: TabBarView(
                physics: PageScrollPhysics(),
                children: [
                  HomePostScreen(),
                  ExploreScreen(constraints: constraints),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
