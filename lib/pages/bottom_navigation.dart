import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lash_map/pages/clients.dart';
import 'package:lash_map/pages/calendar.dart';
import 'package:lash_map/pages/home.dart';
import 'package:lash_map/pages/menu.dart';
import 'package:lash_map/pages/add_scheme/add_scheme.dart';
import 'package:lash_map/utils/app_colors.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  // late StreamSubscription subscription;
  // bool hasInternet = false;
  // ConnectivityResult connectivityResult = ConnectivityResult.none;
  int selectedIndex = 4;
  final screens = const [
    ClientsPage(),
    CalendarPage(),
    AddPage(),
    MenuPage(),
    HomePage()
  ];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // subscription = Connectivity().onConnectivityChanged.listen((result) {
    //   setState(() {
    //     connectivityResult = result;
    //   });
    // });
    // InternetConnectionChecker().onStatusChange.listen((status) {
    //   final hasInternet = status == InternetConnectionStatus.connected;
    //   setState(() {
    //     this.hasInternet = hasInternet;
    //   });
    // });
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
        body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(child: screens[selectedIndex])));
  }
}
