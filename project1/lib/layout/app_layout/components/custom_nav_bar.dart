import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:project1/layout/app_layout/cubit/app_layout_cubit.dart';
import 'package:project1/module/add_post/gallery_add_post_screen.dart';
import 'package:project1/module/chat/cubit/social_cubit.dart';
import 'package:project1/shared/components/size_config.dart';

import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';

Widget customNavigationBar({
  Size? size,
  AppLayoutCubit? cubit,
  context,
}) =>
    Container(
      height: getProportionateScreenHeight(70),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: customNavigationBarColor,
        boxShadow: [
          BoxShadow(
            color: defaultColor,
            offset: Offset(0, 5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        // gradient: LinearGradient(
        //   begin: Alignment.center,
        //   end: Alignment.center,
        //   colors: [
        //     defaultColor,
        //     Color.fromARGB(255, 237, 237, 243),
        //   ],
        // ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              IconBroken.Home,
              color: cubit!.currentIndex == 0 ? defaultColor : Colors.black38,
            ),
            onPressed: () {
              cubit.changeBottomNav(0);
            },
          ),
          IconButton(
            icon: Icon(
              IconBroken.Notification,
              color: cubit.currentIndex == 1 ? defaultColor : Colors.black38,
            ),
            onPressed: () {
              cubit.changeBottomNav(1);
            },
          ),
          InkWell(
            onTap: () {
              PhotoManager.requestPermissionExtend().then((permitted) {
                if (!permitted.isAuth) return;
                Navigator.pushNamed(
                  context,
                  GalleryAddPostScreen.routeName,
                );
              }).catchError((e) {});

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AddpostScreen(),
              //   ),
              // );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: getProportionateScreenHeight(-5),
                  child: Icon(
                    Icons.circle,
                    color: defaultColor.withOpacity(0.099),
                    size: getProportionateScreenHeight(75),
                  ),
                ),
                Icon(
                  Icons.circle,
                  color: defaultColor,
                  size: getProportionateScreenHeight(65),
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: getProportionateScreenHeight(40),
                )
              ],
            ),
          ),
          IconButton(
              icon: Iconify(
                Ph.chats_circle_thin,
                color: cubit.currentIndex == 2 ? defaultColor : Colors.black38,
                size: 31,
              ),
              // Icon(
              //   IconBroken.Chat,
              //   color: cubit.currentIndex == 2 ? defaultColor : Colors.black38,
              // ),
              onPressed: () {
                SocialCubit.get(context).getAllUserResver();
                cubit.changeBottomNav(2);
              }),
          IconButton(
              icon: Icon(
                IconBroken.Profile,
                color: cubit.currentIndex == 3 ? defaultColor : Colors.black38,
              ),
              onPressed: () {
                cubit.changeBottomNav(3);
              }),
        ],
      ),
    );

//!test custem Navigator deferint
// Widget customNavigationBar2({Size? size, AppCubit? cubit}) => Container(
//       width: size!.width,
//       height: 60,
//       child: Stack(
//         children: [
//           CustomPaint(
//             size: Size(size.width, 100),
//             painter: CustomPainterNavigationBar2(),
//           ),
//           Center(
//             heightFactor: 0,
//             child: FloatingActionButton(
//               backgroundColor: defaultColor,
//               child: Icon(
//                 Icons.add,
//                 size: 50,
//               ),
//               elevation: 0.1,
//               onPressed: () {},
//             ),
//           ),
//           Container(
//             width: size.width,
//             height: 80,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     FluentIcons.settings_48_filled,
//                     color: defaultColor,
//                   ),
//                   onPressed: () {
//                     cubit!.changeBottomNav(0);
//                   },
//                   splashColor: Colors.amber,
//                 ),
//                 IconButton(
//                     icon: Icon(
//                       Icons.restaurant_menu,
//                       color: defaultColor,
//                     ),
//                     onPressed: () {
//                       cubit!.changeBottomNav(1);
//                     }),
//                 Container(
//                   width: size.width * 0.20,
//                 ),
//                 IconButton(
//                     icon: Icon(
//                       Icons.bookmark,
//                       color: defaultColor,
//                     ),
//                     onPressed: () {
//                       cubit!.changeBottomNav(2);
//                     }),
//                 IconButton(
//                     icon: Icon(
//                       Icons.notifications,
//                       color: defaultColor,
//                     ),
//                     onPressed: () {
//                       cubit!.changeBottomNav(3);
//                     }),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
