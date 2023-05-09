// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:project1/module/show_post/show_post_screen.dart';
// import 'package:project1/shared/components/components.dart';
// import 'package:project1/shared/components/size_config.dart';
// import 'package:project1/shared/styes/colors.dart';
// import 'package:project1/layout/my_profile_layout/components/custem_image_profile.dart';

// class SSS extends StatelessWidget {
//   static String routeName = "profile";
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     final Size size = MediaQuery.of(context).size;
//     return Material(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
//         child: GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: 15,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: getProportionateScreenWidth(28),
//             mainAxisSpacing: getProportionateScreenHeight(8),
//           ),
//           itemBuilder: (context, index) => buidPostProfileItem(
//             onPress: () {
//               Navigator.pushNamed(context, ShowPostScreen.routeName);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget buidPostProfileItem({
//   required void Function()? onPress,
// }) =>
//     InkWell(
//       onTap: onPress,
//       child: Container(
//         width: getProportionateScreenWidth(165),
//         height: getProportionateScreenWidth(165),
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//               "assets/images/interests/art.jpg",
//             ),
//             fit: BoxFit.cover,
//           ),
//           borderRadius: BorderRadius.all(
//             const Radius.circular(19),
//           ),
//         ),
//       ),
//     );
