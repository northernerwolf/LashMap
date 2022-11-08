import 'package:flutter/material.dart';
import 'package:lash_map/utils/app_colors.dart';

AppBar appBar(String title) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: const Color(0xfffafafa),
    title: Text(
      title,
      style: const TextStyle(color: AppColors.primary),
    ),
  );
}
