import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lash_map/pages/add_new_client.dart';
import 'package:lash_map/pages/auth/change_password.dart';
import 'package:lash_map/pages/bottom_navigation.dart';
import 'package:lash_map/pages/calendar_day.dart';
import 'package:lash_map/pages/edit_client.dart';
import 'package:lash_map/pages/internet_not_connected.dart';
import 'package:lash_map/pages/landing.dart';
import 'package:lash_map/pages/splash.dart';

import '../pages/auth/login.dart';
import '../pages/auth/registration.dart';

void openLogin(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}

Future<void> openAddNewClient(BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const AddNewClientPage(),
    ),
  );
}

Future<void> openEditClient(BuildContext context, int id) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditClientPage(id: id),
    ),
  );
}

Future<void> openCalendarDay(BuildContext context, DateTime selectedDay) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => CalendarDayPage(selectedDay: selectedDay),
    ),
  );
}

void openChangePassword(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const ChangePasswordPage(),
    ),
  );
}

void openLanding(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const LandingPage(),
    ),
  );
}

void openNoInternetPage(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const InternetNotAvailable(),
    ),
  );
}

bool isNumeric(String s) {
  return int.tryParse(s) != null;
}

void openHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const BottomNavPage()),
      (route) => false);
}

void openSplash(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SplashPage()),
      (route) => false);
}

void openRegister(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const RegisterPage(),
    ),
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}
