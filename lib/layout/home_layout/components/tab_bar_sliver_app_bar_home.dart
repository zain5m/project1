import 'package:flutter/material.dart';
import 'package:project1/shared/styes/colors.dart';

class TabBarSliverAppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 0,
      pinned: true,
      bottom: TabBar(
        indicatorColor: defaultColor,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: defaultColor,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        unselectedLabelColor: Color(0xff9f9f9f),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        tabs: [
          Tab(
            text: 'Home',
          ),
          Tab(
            text: "Explore",
          ),
        ],
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(25),
            bottomRight: const Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: defaultColor.withOpacity(0.3),
              offset: const Offset(0, 5),
              blurRadius: 30,
            )
          ],
        ),
      ),
    );
  }
}
