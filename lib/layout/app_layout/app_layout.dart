import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/components/custom_nav_bar.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';

class AppLayout extends StatefulWidget {
  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> with WidgetsBindingObserver {
  void setStatus(bool status) {
    FirebaseFirestore.instance
        .collection('user_chats')
        .doc(CacheHelper.getData(key: USERID).toString())
        .update({
          "online": status,
        })
        .then((value) {})
        .catchError((e) {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus(true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      setStatus(true);
    } else {
      setStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return
        // BlocProvider(
        //   create: (context) => AppLayoutCubit(),
        // child:
        BlocConsumer<AppLayoutCubit, AppLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppLayoutCubit.get(context);

        return SafeArea(
          child: Scaffold(
            extendBody: true,
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: customNavigationBar(
              size: SizeConfig.mediaQueryData.size,
              cubit: cubit,
              context: context,
            ),
          ),
        );
      },
      //   ),
    );
  }
}
