import 'package:flutter/material.dart';
import 'package:lash_map/pages/splash.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const LashMap()));
}

class LashMap extends StatelessWidget {
  const LashMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const SplashPage(),

    );
  }
}
