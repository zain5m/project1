import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';

class TabBarSliverAppBar extends StatelessWidget {
  GlobalKey? keyForBack;

  TabBarSliverAppBar({this.keyForBack});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyProfileLayoutCubit, MyProfileLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        MyProfileLayoutCubit cubit = MyProfileLayoutCubit.get(context);
        return SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: getProportionateScreenHeight(15),
          pinned: true,
          bottom: TabBar(
            indicatorColor: defaultColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.black,
            unselectedLabelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelColor: Color(0xff9f9f9f),
            onTap: (index) {
              if (cubit.currentTabIndex == index) {
                Scrollable.ensureVisible(
                  keyForBack!.currentContext!,
                  duration: Duration(milliseconds: 300),
                );
              } else {
                cubit.changeTabIndex(index);
              }
            },
            tabs: [
              Tab(text: 'Post'),
              Tab(text: 'Prometing'),
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: const Offset(0, 5),
                  blurRadius: 30,
                  spreadRadius: 0,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
