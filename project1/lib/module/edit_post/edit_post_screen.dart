import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/models/home_post/home_post_model.dart';
import 'package:project1/models/interstes/interests_model.dart';
import 'package:project1/models/post_model.dart';
import 'package:project1/module/add_post/cubit/add_post_cubit.dart';
import 'package:project1/module/edit_post/components/choose_post_image_buttom_sheet.dart';
import 'package:project1/module/edit_post/cubit/edit_post_cubit.dart';
import 'package:project1/module/home_post/cubit/home_post_cubit.dart';

import 'package:project1/module/intersts/components/item_Interest.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';
import '../../shared/components/interests_name_item.dart';

class EditPostScreen extends StatelessWidget {
  var postController = TextEditingController();
  PostModel post;
  int index;

  EditPostScreen({
    required this.post,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPostCubit()..getinter(list: post.interestId),
      child: BlocConsumer<EditPostCubit, EditPostStates>(
        listener: (context, state) {},
        builder: (context, state) {
          EditPostCubit cubit = EditPostCubit.get(context);
          print(cubit.selected);
          print(cubit.selectedForAPI);
          postController.text = post.content!;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 1,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
                title: Text(
                  'Edit Post',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  BlocConsumer<HomePostCubit, HomePostStates>(
                    listener: (context, state) {
                      if (state is UpdatePostSuccessState) {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      HomePostCubit cubith = HomePostCubit.get(context);
                      return TextButton(
                        onPressed: () {
                          if (cubit.selectedForAPI.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              validatorSnackBarInterests(
                                state: ToastState.ERROR,
                                text: 'At least one interest must be selected',
                              ),
                            );
                          } else {
                            print(cubit.selectedForAPI);
                            print(post.postId);
                            print(index);
                            cubith.updatePost(
                              index: index,
                              postId: post.postId!,
                              content: postController.text,
                              interestid: cubit.selectedForAPI,
                            );
                          }
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: defaultColor,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            MyProfileLayoutCubit.get(context)
                                        .myProfileData!
                                        .myInfo!
                                        .personal!
                                        .photo !=
                                    null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      "$HOST/$USERIMAGE/${MyProfileLayoutCubit.get(context).myProfileData!.myInfo!.personal!.photo}",
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage: AssetImage(
                                      USERIMAGENULL,
                                    ),
                                  ),
                            SizedBox(width: getProportionateScreenWidth(10)),
                            Text(
                              MyProfileLayoutCubit.get(context)
                                  .myProfileData!
                                  .myInfo!
                                  .personal!
                                  .name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(18)),
                          child: TextFormField(
                            controller: postController,
                            decoration: InputDecoration.collapsed(
                              hintText: "Enter your Description",
                            ),
                            maxLines: null,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '$HOST/$POSTIMAGE/${post.photo}',
                            width: double.infinity,
                            height: getProportionateScreenHeight(329),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // SizedBox(height: getProportionateScreenHeight(5)),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: getProportionateScreenWidth(18)),
                          child: Row(
                            children: [
                              Wrap(
                                children: cubit.selected.isNotEmpty
                                    ? List.generate(
                                        cubit.selected.length,
                                        (index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                right:
                                                    getProportionateScreenWidth(
                                                        10)),
                                            child: Text(
                                              "#${interestsName[cubit.selected[index]]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: defaultColor,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : [
                                        Text(
                                          "#Interest",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: defaultColor,
                                          ),
                                        ),
                                      ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  cubit.changeShowInterste();
                                },
                                icon: Icon(
                                  cubit.iconshowInterste,
                                  size: 35,
                                  color: defaultColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5),
                        ),
                        cubit.showInterste
                            ? SizedBox(
                                height: getProportionateScreenHeight(165),
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 5),
                                  itemCount: interestsName.length,
                                  itemBuilder: (context, index) =>
                                      buildInterestItem(
                                    index: index,
                                    interestsName: interestsName[index],
                                    interestsImage: interestsImage[index],
                                    selected: cubit.selected,
                                    ontap: () {
                                      if (cubit.selected.length < 4) {
                                        cubit.changeInterstsSelected(index);
                                      } else if (cubit.selected.length >= 4 &&
                                          cubit.selected.contains(index)) {
                                        cubit.changeInterstsSelected(index);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          validatorSnackBarInterests(
                                            state: ToastState.ERROR,
                                            text:
                                                'You cannot choose more than two interests',
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
