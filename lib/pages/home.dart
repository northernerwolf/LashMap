import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/components/profile_hat_luxury.dart';
import 'package:lash_map/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Home"),
        CupertinoButton(
            child: Text("sign out"),
            color: Colors.amber,
            onPressed: () {
              prefs.then((value) {
                value.remove("token");
                openLanding(context);
              });
            })
      ],
    );
  }
}
