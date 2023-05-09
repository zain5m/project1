import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/module/follow/build_follow_pepole.dart';
import 'package:project1/module/follow/cubit/follow_cubit.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class FollowingScreen extends StatelessWidget {
  int? userId;
  FollowingScreen({this.userId});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            'Following',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsetsDirectional.only(top: getProportionateScreenHeight(15)),
          child: BlocProvider(
            create: (context) => FollowCubit()..getFollowing(userId: userId),
            child: BlocConsumer<FollowCubit, FollowStates>(
              listener: (context, state) {},
              builder: (context, state) {
                FollowCubit cubit = FollowCubit.get(context);
                return state is FollowGetFollowingLoadingStates
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : cubit.following!.length == 0
                        ? Center(
                            child: Text(
                              'There are no Following.',
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return buildFollowPepole(
                                person: cubit.following![index],
                                context: context,
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            itemCount: cubit.following!.length,
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}
