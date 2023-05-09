import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project1/module/explore/explore_screen.dart';

import 'package:project1/module/home_post/home_post_screen.dart';
import 'package:project1/shared/components/size_config.dart';
import 'package:project1/shared/styes/colors.dart';
import 'package:project1/tes/ne/add_post.dart';

import 'package:project1/tes/ne/profile.dart';
import 'package:project1/tes/ne/sittings.dart';

// class MainScreen1 extends StatefulWidget {
//   static String routeName = "/main";

//   MainScreen1({Key? key}) : super(key: key);

//   @override
//   State<MainScreen1> createState() => _MainScreenState();
// }

// int selectindex = 0;

// class _MainScreenState extends State<MainScreen1> {
//   void x1(int index) {
//     setState(() {
//       selectindex = index;
//     });
//   }

//   List<Person> People = [
//     Person("Mina", "Farhat", 21),
//     Person("Toni", "Issa", 21)
//   ];
//   @override
//   Widget build(BuildContext context) {
//     double hi = MediaQuery.of(context).size.height;
//     double wi = MediaQuery.of(context).size.width;
//     ThemeMode tm = ThemeMode.light;
//     bool swval = true;
//     Icon i = Icon(
//       FluentIcons.weather_sunny_48_filled,
//       size: 35,
//       color: defaultColor,
//     );
//     return SafeArea(
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           body: NestedScrollView(
//             headerSliverBuilder: (context, innerBoxIsScrolled) {
//               return [
//                 PartTopProfileSliverAppBar1(),
//                 TabBarSliverAppBar1(),
//               ];
//             },
//             body: TabBarView(
//               children: [
//                 HomePostScreen(),
//                 ExploreScreen(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TabBarSliverAppBarHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       toolbarHeight: 0,
//       pinned: true,
//       bottom: TabBar(
//         indicatorColor: defaultColor,
//         indicatorSize: TabBarIndicatorSize.label,
//         labelColor: defaultColor,
//         labelStyle: TextStyle(
//           fontWeight: FontWeight.w700,
//           fontSize: 23,
//         ),
//         unselectedLabelColor: Color(0xff9f9f9f),
//         unselectedLabelStyle: TextStyle(
//           fontWeight: FontWeight.w700,
//           fontSize: 23.0,
//         ),
//         tabs: [
//           Tab(
//             text: 'Home',
//           ),
//           Tab(
//             text: "Explore",
//           ),
//         ],
//       ),
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             bottomLeft: const Radius.circular(25),
//             bottomRight: const Radius.circular(25),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0x29000000),
//               offset: const Offset(0, 5),
//               blurRadius: 30,
//               spreadRadius: 0,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PartTopProfileSliverAppBar1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return SliverAppBar(
//       elevation: 0,
//       backgroundColor: Colors.white,
//       toolbarHeight: getProportionateScreenHeight(60),
//       leading: IconButton(
//         icon: Icon(
//           FluentIcons.weather_sunny_48_filled,
//           size: 35,
//           color: defaultColor,
//         ),
//         onPressed: () {
//           // setState(() {
//           //   i = Icon(
//           //     FluentIcons.weather_moon_48_filled,
//           //     size: 35,
//           //     color: defaultColor,
//           //   );
//           // });
//         },
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {
//             // showSearch(
//             //   context: context,
//             //   delegate: SearchPage<Person>(
//             //     barTheme: ThemeData.dark(),
//             //     items: People,
//             //     searchLabel: 'Search people',
//             //     suggestion: Center(
//             //       child: Text('Filter people by name, surname or age'),
//             //     ),
//             //     failure: Center(
//             //       child: Text('No person found :('),
//             //     ),
//             //     filter: (person) => [
//             //       person.name,
//             //       person.surname,
//             //       person.age.toString(),
//             //     ],
//             //     builder: (person) => ListTile(
//             //       title: Text(person.name),
//             //       subtitle: Text(person.surname),
//             //       trailing: Text('${person.age} yo'),
//             //     ),
//             //   ),
//             // );
//           },
//           icon: Padding(
//             padding: EdgeInsets.only(right: 10),
//             child: Icon(
//               FluentIcons.people_search_24_filled,
//               size: 35,
//               color: defaultColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

