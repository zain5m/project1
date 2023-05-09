import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/app_layout/components/custom_nav_bar.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/shared/components/size_config.dart';

class AppLayout extends StatelessWidget {
  static String routeName = "/app_layout";
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
