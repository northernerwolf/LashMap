import 'package:flutter/material.dart';
import 'package:lash_map/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    var prefs = SharedPreferences.getInstance();
    return Center(
      child: TextButton(
        onPressed: () {
          prefs.then(
            (value) {
              value.remove("token");
              openSplash(context);
            },
          );
        },
        child: const Text("Logout"),
      ),
    );
  }
}
