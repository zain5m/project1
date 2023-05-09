// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:project1/layout/my_profile_layout/components/sttings_bottom_shet.dart/custem_language_meun_shape_border.dart';

// import 'package:project1/layout/my_profile_layout/components/part_top_profile_sliver_app_bar.dart';
// import 'package:project1/layout/my_profile_layout/components/sttings_bottom_shet.dart/delete_account_dialog.dart';
// import 'package:project1/layout/my_profile_layout/components/sttings_bottom_shet.dart/language_item.dart';

// import 'package:project1/layout/my_profile_layout/components/sttings_bottom_shet.dart/people_block_bottom_sheet.dart';

// import 'package:project1/layout/my_profile_layout/cubit/my_profile_layout_cubit.dart';
// import 'package:project1/models/Language.dart';
// import 'package:project1/models/register/list_model.dart';
// import 'package:project1/module/change_password/change_password.dart';
// import 'package:project1/shared/components/components.dart';
// import 'package:project1/shared/styes/colors.dart';
// import 'package:project1/shared/styes/icon_broken.dart';

// Widget menuProfileBottomSheet(context) {
//   GlobalKey keyLanguage = GlobalKey();
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Divider(
//         color: defaultColor,
//         thickness: 4,
//         height: 20,
//         indent: MediaQuery.of(context).size.width / 2 - 30,
//         endIndent: MediaQuery.of(context).size.width / 2 - 30,
//       ),
//       ListTile(
//         leading: Icon(
//           Icons.block,
//           color: defaultColor,
//           size: 28,
//         ),
//         title: Text(
//           'People blocking',
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//           showModalBottomSheet(
//             context: context,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(20),
//               ),
//             ),
//             builder: (context) {
//               return peopleBlockBottomSheet(context);
//             },
//           );
//         },
//       ),
//       ListTile(
//         leading: Icon(
//           // Icons.password_sharp,
//           FluentIcons.password_24_regular,
//           color: defaultColor,
//           size: 28,
//         ),
//         title: Text(
//           'Change Passowrd',
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) {
//                 return ChangePasswordScreen();
//               },
//             ),
//           );
//         },
//       ),
//       //TODO:
//       ListTile(
//         leading: Icon(
//           FluentIcons.clipboard_edit_20_regular,
//           color: defaultColor,
//           size: 28,
//         ),
//         title: Text(
//           'Change Intrests',
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//         },
//       ),

//       BlocConsumer<MyProfileLayoutCubit, MyProfileLayoutStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           MyProfileLayoutCubit cubit = MyProfileLayoutCubit.get(context);
//           return ListTile(
//             key: keyLanguage,
//             leading: Icon(
//               FluentIcons.local_language_28_regular,
//               color: defaultColor,
//               size: 28,
//             ),
//             title: Text(
//               'Language',
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             onTap: () async {
//               final keyContext = keyLanguage.currentContext;
//               final box = keyContext!.findRenderObject() as RenderBox;
//               final pos = box.localToGlobal(Offset.zero);
//               var selected = await showMenu(
//                 shape: CustemLanguageMeunShapeBorder(),
//                 context: context,
//                 position: RelativeRect.fromLTRB(double.infinity,
//                     pos.dy - (box.size.height + (box.size.height / 4)), 0, 0),
//                 items: List.generate(
//                   Language.languageList().length,
//                   (index) => languageItem(
//                     index: index,
//                     cubit: cubit,
//                   ),
//                   // PopupMenuItem(
//                   //   // checked: false,
//                   //   value: 2,
//                   //   child: ListTile(
//                   //     selected: Language.languageList()[index].id ? true : false,
//                   //     selectedColor: Colors.black,
//                   //     selectedTileColor: Colors.black.withOpacity(0.1),
//                   //     leading: Text(Language.languageList()[index].flag),
//                   //     title: Text(Language.languageList()[index].name),
//                   //   ),
//                   // ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       ListTile(
//         leading: Icon(
//           IconBroken.Logout,
//           // FluentIcons.arrow_exit_20_filled,
//           color: defaultColor,
//           size: 28,
//         ),
//         title: Text(
//           'Logout',
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               // return logoutDialog(context);
//             },
//           );
//         },
//       ),
//       ListTile(
//         leading: Icon(
//           FluentIcons.delete_48_regular,
//           color: Colors.red.shade500,
//           size: 28,
//         ),
//         title: Text(
//           'Delete Account',
//           style: TextStyle(
//             color: Colors.red,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         onTap: () {
//           Navigator.pop(context);
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return deleteAccountDialog(context);
//             },
//           );
//         },
//       ),
//     ],
//   );
// }
