import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lash_map/pages/add.dart';
import 'package:lash_map/pages/calendar.dart';
import 'package:lash_map/pages/home.dart';
import 'package:lash_map/pages/menu.dart';
import 'package:lash_map/pages/profile.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:lash_map/utils/app_icons.dart';
import 'package:lash_map/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int selectedIndex = 0;
  final screens = const [
    ProfilePage(),
    CalendarPage(),
    AddPage(),
    MenuPage(),
    HomePage()
  ];
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? " ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          selectedItemColor: AppColors.blue,
          unselectedItemColor: AppColors.primary,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_2_fill), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.add_circled_solid,
                  color: AppColors.secondary,
                  size: 36,
                ),
                label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill), label: ""),
          ],
        ),
        body: SafeArea(child: screens[selectedIndex]));
  }
}
