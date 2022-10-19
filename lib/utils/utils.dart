import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/pages/registration.dart';

import '../pages/login.dart';

void openLogin(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}

void openRegister(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const RegisterPage(),
    ),
  );
}
