import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/models/post_model.dart';
import 'package:project1/module/show_post/show_post_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/layout/my_profile_layout/components/buid_post_profile_item.dart';

class PeofilePostScreen extends StatelessWidget {
  List<PostModel>? posts;

  PeofilePostScreen({
    required this.posts,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(
            top: getProportionateScreenHeight(20),
            end: getProportionateScreenWidth(10),
            start: getProportionateScreenWidth(10)),
        child:
            // BlocConsumer<MyProfileLayoutCubit, MyProfileLayoutStates>(
            //   listener: (context, state) {},
            //   builder: (context, state) {
            //     MyProfileLayoutCubit cubit = MyProfileLayoutCubit.get(context);
            // return
            posts!.length == 0
                ? Center(
                    child: Text(
                      'Opss... ,There are no posts. You can publish the first post',
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
