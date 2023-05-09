import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
import 'package:project1/models/post_model.dart';
import 'package:project1/models/profile_model.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:project1/shared/network/local/end_point.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/shared/styes/icon_broken.dart';
import 'package:project1/layout/my_profile_layout/components/part_top_profile.dart';

class PartTopProfileSliverAppBar extends StatelessWidget {
  ScrollController? scrollController;
  GlobalKey? keyForBack;
  Widget? childBottomSheet;
  var icon;
  Widget? background;
  void Function()? onPressed;
  PartTopProfileSliverAppBar({
    required this.scrollController,
    required this.keyForBack,
    required this.icon,
    required this.background,
    this.childBottomSheet,
    this.onPressed,
  });
  var curntUser = CacheHelper.getData(key: USERID);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SliverAppBar(
      key: keyForBack,
      elevation: 0,
      expandedHeight: getProportionateScreenHeight(330),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: childBottomSheet != null
              ? () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: childBottomSheet,
                    ),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  );
                }
              : onPressed,
          icon: Icon(
            icon,
            color: defaultColor,
          ),
        ),

        // },
        // ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: background,
      ),
    );
  }
}

// class PopUpMen extends StatelessWidget {
//   final List<PopupMenuEntry> menuList;
//   final Widget? icon;
//   const PopUpMen({Key? key, required this.menuList, this.icon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       itemBuilder: ((context) => menuList),
//       child: icon,
//       // color: Colors.black,
//       // icon:
//     );
//   }
// }

//  PopUpMen(
//         menuList: [
//           PopupMenuItem(
//             value: 'sa',
//             child: ListTile(
//               leading: Icon(
//                 Icons.language,
//                 color: defaultColor,
//                 // size: 30,
//               ),
//               title: Text(
//                 'English',
//                 style: TextStyle(
//                     // fontSize: 16,
//                     // fontWeight: FontWeight.w500,
//                     ),
//               ),
//               onTap: () {
//                 // Navigator.pop(context);
//               },
//             ),
//           ),
//           PopupMenuDivider(),
//           // PopupMenuItem(
//           //   child: ListTile(
//           //     leading: Icon(
//           //       CupertinoIcons.person,
//           //     ),
//           //     title: Text("My Profile"),
//           //   ),
//           // ),
//           PopupMenuItem(
//             child: ListTile(
//               leading: Icon(
//                 Icons.language,
//                 color: defaultColor,
//                 // size: 30,
//               ),
//               title: Text(
//                 'Arabic',
//                 style: TextStyle(
//                     // fontSize: 16,
//                     // fontWeight: FontWeight.w500,
//                     ),
//               ),
//             ),
//           ),
//         ],
//         icon: ListTile(
//           leading: Icon(
//             FluentIcons.local_language_28_regular,
//             size: 28,
//             color: defaultColor,
//           ),
//           title: const Text(
//             "Language",
//             style: TextStyle(
//               color: Colors.amber,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
