import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lash_map/pages/splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lash_map/providers/category_provider.dart';
import 'package:lash_map/providers/custom_lash_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    initializeDateFormatting().then((_) => runApp(const LashMap()));
  });
}

class LashMap extends StatelessWidget {
  const LashMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomLashProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
