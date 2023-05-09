// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:project1/module/show_post/show_post_screen.dart';
// import 'package:project1/shared/components/components.dart';
// import 'package:project1/shared/components/size_config.dart';
// import 'package:project1/shared/styes/colors.dart';
// import 'package:project1/layout/my_profile_layout/components/custemImageProfile.dart';

// class Profile extends StatelessWidget {
//   static String routeName = "profile";

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     final Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white.withOpacity(0.9),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: getProportionateScreenHeight(356),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     // bottomLeft: const Radius.circular(30),
//                     bottomRight: const Radius.circular(30),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0x29000000),
//                       offset: const Offset(0, 5),
//                       blurRadius: 30,
//                       spreadRadius: 0,
//                     )
//                   ],
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(
//                           height: 30,
//                         ),
//                         ClipPath(
//                           clipper: CustomClipperImageProfile(),
//                           child: Stack(
//                             children: [
//                               Container(
//                                 height: getProportionateScreenHeight(300),
//                                 width: 160,
//                                 decoration: BoxDecoration(
//                                   color: Colors.amber,
//                                 ),
//                                 child: InkWell(
//                                   onTap: () {
//                                     showModalBottomSheet(
//                                         context: context,
//                                         builder: (context) {
//                                           return Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: <Widget>[
//                                               ListTile(
//                                                 leading: Icon(
//                                                   FluentIcons.image_48_filled,
//                                                   color: defaultColor,
//                                                   size: 30,
//                                                 ),
//                                                 title: Text(
//                                                   'Show Photo',
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 onTap: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                               ),
//                                               ListTile(
//                                                 leading: Icon(
//                                                   FluentIcons
//                                                       .shape_intersect_24_filled,
//                                                   color: defaultColor,
//                                                   size: 30,
//                                                 ),
//                                                 title: Text(
//                                                   'Show story',
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                   ),
//                                                 ),
//                                                 onTap: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                               ),
//                                             ],
//                                           );
//                                         });
//                                   },
//                                   child: Stack(
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/interests/graphic_design.jpg',
//                                         fit: BoxFit.cover,
//                                         // width: size.width * 0.345,
//                                         height:
//                                             getProportionateScreenHeight(300),
//                                       ),
//                                       CustomPaint(
//                                         size: Size(size.width, 356),
//                                         painter: CustomPainterPr(),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               // Image.asset(
//                               //   'assets/images/interests/fashion.jpg',
//                               //   fit: BoxFit.cover,
//                               //   width: size.width * 0.5,
//                               //   height: getProportionateScreenHeight(356),
//                               // ),
//                             ],
//                           ),
//                           // ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 8,
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           top: 20,
//                           right: 10,
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: getProportionateScreenHeight(40)),
//                             Text(
//                               "Mina farhat",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 25,
//                               ),
//                             ),
//                             SizedBox(height: getProportionateScreenHeight(10)),
//                             Text(
//                               "welcom to my profile and you have the  right amount of time to ",
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontStyle: FontStyle.italic,
//                                 // fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(height: getProportionateScreenHeight(25)),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Column(
//                                   // mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       "846",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Post",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   // mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       "846",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Followers",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   // mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       "568",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Following",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: getProportionateScreenHeight(30)),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 defaultButton(
//                                   function: () {},
//                                   text: 'Follow',
//                                   radius: 20,
//                                   width: getProportionateScreenHeight(120),
//                                   isBorderColor: false,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.w700,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.black26,
//                                         offset: Offset(0, 4),
//                                         blurRadius: 5.0)
//                                   ],
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     stops: [0.0, 1.0],
//                                     colors: [
//                                       defaultColor,
//                                       Color(0xff5564ff),
//                                     ],
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {},
//                                   child: Container(
//                                     height: 48,
//                                     decoration: BoxDecoration(
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.black26,
//                                             offset: Offset(0, 4),
//                                             blurRadius: 5.0)
//                                       ],
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                         stops: [0.0, 1.0],
//                                         colors: [
//                                           defaultColor,
//                                           Color(0xff5564ff),
//                                         ],
//                                       ),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 8.0,
//                                           horizontal: 15,
//                                         ),
//                                         child: Icon(
//                                           FluentIcons.chat_48_filled,
//                                           color: Colors.white,
//                                           size: 25,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: getProportionateScreenHeight(50)),
//                             // Spacer(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // child: Padding(
//                 //   padding: const EdgeInsets.only(top: 22, bottom: 17),
//                 //   child: Column(
//                 //     children: [
//                 //       Container(
//                 //         width: 116,
//                 //         height: 115,
//                 //         decoration: BoxDecoration(
//                 //           gradient: LinearGradient(
//                 //             colors: [
//                 //               Color(0xfffc0b7b),
//                 //               Color(0xff7820ad),
//                 //             ],
//                 //           ),
//                 //           border: Border.all(
//                 //             color: Colors.transparent,
//                 //             width: 5,
//                 //           ),
//                 //           borderRadius: BorderRadius.circular(60),
//                 //           color: Colors.white,
//                 //         ),
//                 //         child: ClipOval(
//                 //           child: Image.asset(
//                 //             "assets/images/interests/art.jpg",
//                 //             fit: BoxFit.cover,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //       SizedBox(height: getProportionateScreenHeight(5)),
//                 //       Text(
//                 //         "Mina farhat",
//                 //         style: TextStyle(
//                 //           color: Colors.black,
//                 //           fontWeight: FontWeight.w700,
//                 //           fontSize: 25,
//                 //         ),
//                 //       ),
//                 //       SizedBox(height: getProportionateScreenHeight(52)),
//                 //       Row(
//                 //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //         children: [
//                 //           Expanded(
//                 //             child: Column(
//                 //               children: [
//                 //                 Text(
//                 //                   "846",
//                 //                   style: TextStyle(
//                 //                     color: Colors.black,
//                 //                     fontSize: 20,
//                 //                     fontWeight: FontWeight.w700,
//                 //                   ),
//                 //                 ),
//                 //                 Text(
//                 //                   "Post",
//                 //                   style: TextStyle(
//                 //                     color: Colors.black,
//                 //                     fontSize: 20,
//                 //                     fontWeight: FontWeight.w700,
//                 //                   ),
//                 //                 ),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //           Expanded(
//                 //             child: Column(
//                 //               children: [
//                 //                 Text(
//                 //                   "846",
//                 //                   style: TextStyle(
//                 //                     color: Colors.black,
//                 //                     fontSize: 20,
//                 //                     fontWeight: FontWeight.w700,
//                 //                   ),
//                 //                 ),
//                 //                 Text(
//                 //                   "Followers",
//                 //                   style: TextStyle(
//                 //                     color: Colors.black,
//                 //                     fontSize: 20,
//                 //                     fontWeight: FontWeight.w700,
//                 //                   ),
//                 //                 ),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //           Expanded(
//                 //             child: Column(
//                 //               children: [
//                 //                 Text(
//                 //                   "568",
//                 //                   style: TextStyle(
//                 //                     color: Colors.black,
//                 //                     fontSize: 20,
//                 //                     fontWeight: FontWeight.w700,
//                 //                   ),
//                 //                 ),
//                 //                 Text(
//                 //                   "Following",
//                 //                   style: TextStyle(
//                 //                     color: Colors.black,
//                 //                     fontSize: 20,
//                 //                     fontWeight: FontWeight.w700,
//                 //                   ),
//                 //                 ),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //         ],
//                 //       ),
//                 //       SizedBox(height: getProportionateScreenHeight(22)),
//                 //       defaultButton(
//                 //         function: () {},
//                 //         text: 'Edit profile',
//                 //         radius: 20,
//                 //         width: getProportionateScreenHeight(170),
//                 //         isBorderColor: false,
//                 //         fontSize: 20.0,
//                 //         fontWeight: FontWeight.w700,
//                 //         boxShadow: [
//                 //           BoxShadow(
//                 //               color: Colors.black26,
//                 //               offset: Offset(0, 4),
//                 //               blurRadius: 5.0)
//                 //         ],
//                 //         gradient: LinearGradient(
//                 //           begin: Alignment.topLeft,
//                 //           end: Alignment.bottomRight,
//                 //           stops: [0.0, 1.0],
//                 //           colors: [
//                 //             defaultColor,
//                 //             Color(0xff5564ff),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//               ),
//               const Text(
//                 "Post",
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                 ),
//               ),
//               Divider(
//                 color: defaultColor,
//                 endIndent: getProportionateScreenWidth(150),
//                 indent: getProportionateScreenWidth(150),
//                 thickness: 5,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
//                 child: GridView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: 15,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: getProportionateScreenWidth(28),
//                     mainAxisSpacing: getProportionateScreenHeight(8),
//                   ),
//                   itemBuilder: (context, index) => buidPostProfileItem(
//                     onPress: () {
//                       Navigator.pushNamed(context, ShowPostScreen.routeName);
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: CurvedNavigationBar(
//           color: Colors.grey.shade100,
//           backgroundColor: defaultColor,
//           buttonBackgroundColor: const Color(0xFFF5F5F5),
//           animationCurve: Curves.linearToEaseOut,
//           index: 2,
//           height: 45,
//           items: [
//             const Icon(
//               FluentIcons.settings_48_filled,
//               size: 30,
//               color: defaultColor,
//             ),
//             const Icon(
//               FluentIcons.chat_multiple_24_filled,
//               size: 30,
//               color: defaultColor,
//             ),
//             const Icon(
//               FluentIcons.add_28_filled,
//               size: 40,
//               color: defaultColor,
//             ),
//             const Icon(
//               Icons.notifications_rounded,
//               size: 30,
//               color: defaultColor,
//             ),
//             const Icon(
//               FluentIcons.home_48_filled,
//               size: 30,
//               color: defaultColor,
//             ),
//           ],
//           onTap: (index) {
//             if (index == 0) {
//               // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//               //   return Sittings();
//               // }));
//             }
//             if (index == 1) {}
//             if (index == 4) {
//               // Navigator.of(context)
//               //     .pushReplacement(MaterialPageRoute(builder: (_) {
//               //   return MainScreen1();
//               // }));
//             }
//           },
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
