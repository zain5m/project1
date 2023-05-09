import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/models/explore_model.dart';
import 'package:project1/module/explore/buildListExplore.dart';
import 'package:project1/module/explore/buildPostExploreItem.dart';
import 'package:project1/module/explore/cubit/explore_cubit.dart';
import 'package:project1/module/show_post/show_post_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/routes/routes.dart';
import 'package:project1/shared/styes/colors.dart';

class ExploreScreen extends StatelessWidget {
  BoxConstraints? constraints;
  ExploreScreen({this.constraints});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(CacheHelper.getData(key: TOKEN));
    return BlocProvider(
      create: (context) => ExploreCubit()..getData(),
      child: BlocConsumer<ExploreCubit, ExploreStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ExploreCubit cubit = ExploreCubit().get(context);
          return Scaffold(
            body: state is ExploreGetDataLoadingState?
                ? Center(child: CircularProgressIndicator())
                : cubit.dataRight.length == 0 && cubit.dataLeft.length == 0
                    ? Center(
                        child: Text(
                          "Opss... ,There are no posts. You can publish the first post",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildListExplore(
                              context: context,
                              constraints: constraints!,
                              list: cubit.dataRight,
                              isRight: true,
                            ),
                            buildListExplore(
                              context: context,
                              constraints: constraints!,
                              list: cubit.dataLeft,
                              isRight: false,
                            ),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }
}

// child: SelectableText(
//   'ssssss',
//   style: TextStyle(color: Colors.white),
//   toolbarOptions: ToolbarOptions(
//     copy: true,
//   ),
// ),
// 'https://cdn5.vectorstock.com/i/thumb-large/45/59/profile-photo-placeholder-icon-design-in-gray-vector-37114559.jpg',
