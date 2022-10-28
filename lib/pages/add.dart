import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/components/profile_hat_luxury.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_colors.dart';
import '../utils/utils.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text("Add");
  }
}
