import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:project1/shared/styes/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

int selectindex = 0;

class _MainScreenState extends State<MainScreen> {
  String str = "Home screen";
  void x1(int index) {
    setState(() {
      selectindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    print(hi);
    print(wi);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 93,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 5),
                        blurRadius: 30,
                        spreadRadius: 0)
                  ],
                  color: const Color(0xffffffff)),
              child: Column(
                children: [
                  Container(
                    width: wi * .8102189781,
                    height: 45,
                    child: TextField(
                      cursorColor: defaultColor,
                      decoration: InputDecoration(
                        fillColor: Color(0xfff2f2f2),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22.5),
                        ),
                        hintText: "Search",
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffb6b7b7)),
                        prefixIcon: Icon(
                          FluentIcons.search_48_filled,
                          size: 35,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(15),
            //   child: Container(
            //     color: Colors.white70,
            //     child: Column(
            //       children: [
            //         Row(
            //           children: [
            //             CircleAvatar(
            //               backgroundColor: Colors.amber,
            //               radius: 30,
            //             ),
            //             SizedBox(width: 10),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text("Mauricio Lopez",
            //                     style: TextStyle(
            //                       fontFamily: 'Archivo',
            //                       color: Color(0xff181818),
            //                       fontSize: 17,
            //                       fontWeight: FontWeight.w700,
            //                       fontStyle: FontStyle.normal,
            //                     )),
            //                 Opacity(
            //                   opacity: 0.5,
            //                   child: Text("20 min ago",
            //                       style: const TextStyle(
            //                           color: const Color(0xff000000),
            //                           fontWeight: FontWeight.w400,
            //                           fontFamily: "Archivo",
            //                           fontStyle: FontStyle.normal,
            //                           fontSize: 10.0),
            //                       textAlign: TextAlign.left),
            //                 )
            //               ],
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        // bottomNavigationBar: CurvedNavigationBar(
        //   color: Colors.grey.shade100,
        //   backgroundColor: defaultColor,
        //   buttonBackgroundColor: Color(0xFFF5F5F5),
        //   animationCurve: Curves.linearToEaseOut,
        //   index: 2,
        //   height: 45,
        //   items: [
        //     Icon(
        //       FluentIcons.list_28_filled,
        //       size: 30,
        //       color: defaultColor,
        //     ),
        //     Icon(
        //       FluentIcons.chat_multiple_24_filled,
        //       size: 30,
        //       // color: defaultColor,
        //     ),
        //     Icon(
        //       FluentIcons.add_28_filled,
        //       size: 40,
        //       color: defaultColor,
        //     ),
        //     Icon(
        //       Icons.notifications_rounded,
        //       size: 30,
        //       color: defaultColor,
        //     ),
        //     Icon(
        //       FluentIcons.person_48_filled,
        //       size: 30,
        //       color: defaultColor,
        //     ),
        //   ],
        //   onTap: (index) {
        //     setState(() {
        //       if (index == 0) {
        //         Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //           return Drawer(
        //             child: ListView(
        //               padding: EdgeInsets.zero,
        //               children: [
        //                 UserAccountsDrawerHeader(
        //                   accountName: Text(
        //                     "Mina farhat",
        //                     style: TextStyle(fontSize: 19),
        //                   ),
        //                   accountEmail: Text("Mina.farhat@gmail.com"),
        //                   currentAccountPicture: CircleAvatar(
        //                     child: InkWell(
        //                         child: ClipOval(
        //                           child: Image.network(
        //                             "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        //                             width: 90,
        //                             height: 90,
        //                             fit: BoxFit.cover,
        //                           ),
        //                         ),
        //                         onTap: () {}),
        //                   ),
        //                   decoration: BoxDecoration(
        //                     color: defaultColor,
        //                     image: const DecorationImage(
        //                       image: AssetImage("images/2.png"),
        //                       fit: BoxFit.cover,
        //                     ),
        //                   ),
        //                 ),
        //                 ListTile(
        //                   leading: Icon(
        //                     Icons.face_outlined,
        //                     size: 35,
        //                     color: defaultColor,
        //                   ),
        //                   title: const Text(
        //                     "Profile",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                   onTap: () => print("Done"),
        //                 ),
        //                 ListTile(
        //                   leading: Icon(
        //                     Icons.chat_bubble_rounded,
        //                     size: 35,
        //                     color: defaultColor,
        //                   ),
        //                   title: const Text(
        //                     "Chat",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                   onTap: () => null,
        //                 ),
        //                 ListTile(
        //                   leading: Icon(
        //                     Icons.favorite,
        //                     size: 35,
        //                     color: defaultColor,
        //                   ),
        //                   title: const Text(
        //                     "Followers",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                   onTap: () => null,
        //                 ),
        //                 ListTile(
        //                   leading: Icon(
        //                     Icons.notifications_rounded,
        //                     size: 35,
        //                     color: defaultColor,
        //                   ),
        //                   title: const Text(
        //                     "Notifications",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                   trailing: ClipOval(
        //                     child: Container(
        //                       color: Colors.red.shade700,
        //                       width: 20,
        //                       height: 20,
        //                       child: const Center(
        //                         child: Text(
        //                           "8",
        //                           style: TextStyle(
        //                             color: Colors.white,
        //                             fontSize: 12,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   onTap: () => null,
        //                 ),
        //                 const Divider(height: 20),
        //                 ListTile(
        //                   leading: Icon(
        //                     Icons.settings,
        //                     size: 35,
        //                     color: defaultColor,
        //                   ),
        //                   title: const Text(
        //                     "Settings",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                   onTap: () => null,
        //                 ),
        //                 ListTile(
        //                   leading: Icon(
        //                     Icons.language,
        //                     size: 35,
        //                     color: defaultColor,
        //                   ),
        //                   title: const Text(
        //                     "Language",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                   onTap: () => null,
        //                 ),
        //                 ListTile(
        //                   leading: Icon(
        //                     Icons.share,
        //                     size: 35,
        //                     color: defaultColor,
        //                   ),
        //                   title: const Text(
        //                     "Share Us",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                   onTap: () => null,
        //                 ),
        //                 const Divider(height: 20),
        //                 ListTile(
        //                   leading: Icon(
        //                     Icons.exit_to_app_rounded,
        //                     size: 35,
        //                     color: defaultColor,
        //                   ),
        //                   title: const Text(
        //                     "Exit",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                   onTap: () => null,
        //                 ),
        //               ],
        //             ),
        //           );
        //           ;
        //         }));
        //       }
        //       // if (index == 2) {

        //       // }
        //       if (index == 1) {}
        //       if (index == 4) {
        //         // Navigator.of(context)
        //         //     .pushReplacement(MaterialPageRoute(builder: (_) {
        //         //   return ProfileScreen();
        //         // }));
        //       }
        //     });
        //   },
        // ),
      ),
    );
  }
}
