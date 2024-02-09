import 'package:auth_app/components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogOutTap;

  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onLogOutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(45, 103, 48, 1),
      child: Column(
        children: [
          // header
          const DrawerHeader(
            child: Icon(
              Icons.person,
              color: Color.fromARGB(255, 244, 244, 244),
              size: 100,
            ),
          ),

          // home navigator
          MyListTile(
            icon: Icons.home,
            text: 'H O M E',
            onTap: () => Navigator.pop(context),
          ),
          // profile navigator
          MyListTile(
            icon: Icons.person_outlined,
            text: 'P R O F I L E',
            onTap: onProfileTap,
          ),
          // logout
          MyListTile(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: onLogOutTap,
          ),
        ],
      ),
    );
  }
}
