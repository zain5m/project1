import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/layout/my_profile_layout/my_profile_layout.dart';
import 'package:project1/module/add_story/gallery/gallery_add_story_screen.dart';
import 'package:project1/module/home_post/cubit/home_post_cubit.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/remote/end_points.dart';
import 'package:project1/shared/styes/colors.dart';

class buidMyStoey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(72),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              PhotoManager.requestPermissionExtend().then((permitted) {
                if (!permitted.isAuth) return;

                availableCameras().then((value) {
                  navigateTo(
                    context,
                    GalleryAddStoryScreen(cameras: value),
                  );
                }).catchError((e) {
                  print(e.toString());
                });
              }).catchError((e) {});
            },
            child: Stack(
              fit: StackFit.loose,
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: getProportionateScreenWidth(60),
                  height: getProportionateScreenWidth(60),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment(0.5, 0),
                      end: Alignment(0.5, 1),
                      colors: [
                        defaultColor,
                        defaultSecondColor,
                      ],
                    ),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child:
                      BlocBuilder<MyProfileLayoutCubit, MyProfileLayoutStates>(
                    builder: (context, state) {
                      MyProfileLayoutCubit cubit =
                          MyProfileLayoutCubit.get(context);
                      return cubit.myProfileData == null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: CircularProgressIndicator(),
                            )
                          : cubit.myProfileData!.myInfo!.personal!.photo != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "$HOST/$USERIMAGE/${cubit.myProfileData!.myInfo!.personal!.photo}",
                                  ),
                                  radius: 5,
                                )
                              : CircleAvatar(
                                  backgroundImage: AssetImage(
                                    USERIMAGENULL,
                                  ),
                                  radius: 5,
                                );
                    },
                  ),
                ),
                Positioned(
                  bottom: getProportionateScreenHeight(-7),
                  child: Container(
                    width: getProportionateScreenWidth(22),
                    height: getProportionateScreenHeight(22),
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment(0.5, 0),
                        end: Alignment(0.5, 1),
                        colors: [
                          defaultColor,
                          defaultSecondColor,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: getProportionateScreenHeight(15),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Text(
            'add Story',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xff787c81),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget buidMyStoey() => SizedBox(
//       width: 72,
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {},
//             child: Stack(
//               clipBehavior: Clip.none,
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Container(
//                   width: 75,
//                   height: 75,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       begin: Alignment(0.5, 0),
//                       end: Alignment(0.5, 1),
//                       colors: [
//                         const Color(0xff21115c),
//                         const Color(0xff8564ff),
//                       ],
//                     ),
//                     border: Border.all(
//                       color: Colors.transparent,
//                       width: 3,
//                     ),
//                   ),
//                   child: CircleAvatar(
//                     backgroundImage: AssetImage(
//                       //TODO: Add Image current user

//                       'assets/images/interests/animal.jpg',
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: -4,
//                   child: Container(
//                     width: 23,
//                     height: 23,
//                     alignment: Alignment.topCenter,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                       gradient: LinearGradient(
//                         begin: Alignment(0.5, 0),
//                         end: Alignment(0.5, 1),
//                         colors: [
//                           const Color(0xff21115c),
//                           const Color(0xff8564ff),
//                         ],
//                       ),
//                     ),
//                     child: Icon(
//                       Icons.add,
//                       size: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 5.0,
//           ),
//           Text(
//             'Your Story',
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               color: Color(0xff787c81),
//               fontSize: 13,
//             ),
//           ),
//         ],
//       ),
//     );
