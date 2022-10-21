import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/pages/bottom_navigation.dart';
import 'package:lash_map/pages/landing.dart';
import 'package:lash_map/pages/registration.dart';
import 'package:lash_map/pages/splash.dart';

import '../pages/login.dart';

void openLogin(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
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
