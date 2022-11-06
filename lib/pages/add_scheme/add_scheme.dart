import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/components/profile_hat_luxury.dart';
import 'package:lash_map/db/repo/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_colors.dart';
import '../../utils/utils.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Column(
        children: [
          const SizedBox(
            height: 106.0,
          ),
          const FittedBox(
            child: Text(
              'ВЫБРАТЬ СХЕМУ',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 100.0,
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
              onPressed: () {},
              child: const Text(
                'ГОТОВЫЙ ШАБЛОН',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
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
                openAddCustomScheme(context);
              },
              child: const Text(
                'РУЧНАЯ НАСТРОЙКА',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
