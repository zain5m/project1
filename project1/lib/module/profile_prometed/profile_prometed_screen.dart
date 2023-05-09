import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/models/post_model.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/layout/my_profile_layout/components/buid_post_profile_item.dart';

class ProfilePrometedScreen extends StatelessWidget {
  List<PostModel>? posts;

  ProfilePrometedScreen({required this.posts});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child:
            // BlocConsumer<MyProfileLayoutCubit, MyProfileLayoutStates>(
            // listener: (context, state) {},
            // builder: (context, state) {
            // MyProfileLayoutCubit cubit = MyProfileLayoutCubit.get(context);
            // return state is MyProfileLayoutGetDataProfileLoadingStates
            posts!.length == 0
                ? Center(
                    child: Text(
                      'Opss...There are no promoted posts. You can promote your posts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  )
                : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: posts!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: getProportionateScreenWidth(10),
                      mainAxisSpacing: getProportionateScreenHeight(10),
                    ),
                    itemBuilder: (context, index) => buidPostProfileItem(
                      post: posts![index],
                      context: context,
                    ),
                  ),
        //   },
        // ),
      ),
    );
  }
}
