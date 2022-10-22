import 'package:flutter/material.dart';
import 'package:lash_map/pages/registration.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:lash_map/utils/utils.dart';

import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: double.infinity,
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primary,
                onPrimary: Colors.black,
                shadowColor: Colors.grey,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
              ),
              onPressed: () {
                openLogin(context);
              },
              child: const Text(
                'ВХОД',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primary,
                onPrimary: Colors.black,
                shadowColor: Colors.grey,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
              ),
              onPressed: () {
                openRegister(context);
              },
              child: const Text(
                'РЕГИСТРАЦИЯ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ]),
      )),
    );
  }
}
