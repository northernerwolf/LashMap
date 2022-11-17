import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/providers/category_provider.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:lash_map/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    var prefs = SharedPreferences.getInstance();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      physics: const BouncingScrollPhysics(),
      child: Column(children: [
        const SizedBox(
          height: 40,
        ),
        const Center(
          child: Text(
            "УПРАВЛЕНИЕ УСЛУГАМИ",
            style: TextStyle(fontSize: 24, color: AppColors.primary),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Stack(
          children: [
            Visibility(
              visible: categoryProvider.isCategoryExpanded,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(4, 4),
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 16)
                    ],
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(13))),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          categoryProvider.setIsAddingNewCategory(true);
                        },
                        icon: const Icon(
                          CupertinoIcons.add_circled_solid,
                          size: 32,
                          color: AppColors.secondary,
                        ))
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 35,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: const Offset(4, 4),
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 16)
              ]),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  onPrimary: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                ),
                onPressed: () {
                  categoryProvider.updateIsCategoryExpanded();
                },
                child: const Text(
                  'КАТЕГОРИИ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          height: 35,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(4, 4),
                color: Colors.black.withOpacity(0.25),
                blurRadius: 16)
          ]),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.primary,
              onPrimary: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13)),
            ),
            onPressed: () {},
            child: const Text(
              'УСЛУГИ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        TextButton(
          onPressed: () {
            prefs.then(
              (value) {
                value.remove("token");
                openSplash(context);
              },
            );
          },
          child: const Text("Logout *dont touch"),
        ),
      ]),
    );
  }
}
