import 'package:flutter/material.dart';
import 'package:project1/shared/styes/colors.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Mina farhat",
              style: TextStyle(fontSize: 19),
            ),
            accountEmail: Text("Mina.farhat@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: InkWell(
                  child: ClipOval(
                      // child: Image.network(
                      //   "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      //   width: 90,
                      //   height: 90,
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  onTap: () {}),
            ),
            decoration: BoxDecoration(
              color: defaultColor,
              // image: const DecorationImage(
              //   image: AssetImage("images/2.png"),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.face_outlined,
              size: 35,
              color: defaultColor,
            ),
            title: const Text(
              "Profile",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            onTap: () => print("Done"),
          ),
          ListTile(
            leading: Icon(
              Icons.chat_bubble_rounded,
              size: 35,
              color: defaultColor,
            ),
            title: const Text(
              "Chat",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              size: 35,
              color: defaultColor,
            ),
            title: const Text(
              "Followers",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_rounded,
              size: 35,
              color: defaultColor,
            ),
            title: const Text(
              "Notifications",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            trailing: ClipOval(
              child: Container(
                color: Colors.red.shade700,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text(
                    "8",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            onTap: () => null,
          ),
          const Divider(height: 20),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 35,
              color: defaultColor,
            ),
            title: const Text(
              "Settings",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              size: 35,
              color: defaultColor,
            ),
            title: const Text(
              "Language",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              size: 35,
              color: defaultColor,
            ),
            title: const Text(
              "Share Us",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            onTap: () => null,
          ),
          const Divider(height: 20),
          ListTile(
            leading: Icon(
              Icons.exit_to_app_rounded,
              size: 35,
              color: defaultColor,
            ),
            title: const Text(
              "Exit",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
