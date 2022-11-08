import 'package:flutter/material.dart';
import 'package:lash_map/components/app_bar.dart';
import 'package:lash_map/pages/add_scheme/custom_scheme_settings/add_zones.dart';
import 'package:lash_map/pages/add_scheme/custom_scheme_settings/bending.dart';
import 'package:lash_map/pages/add_scheme/custom_scheme_settings/volume.dart';
import 'package:provider/provider.dart';

import '../../providers/custom_lash_provider.dart';

class AddCustomSchemePage extends StatelessWidget {
  const AddCustomSchemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final addZonesProvider = Provider.of<CustomLashProvider>(context);

    return Scaffold(
      appBar: appBar("РУЧНАЯ НАСТРОЙКА"),
      body: Column(
        children: [
          Image.asset("assets/images/eye1.png"),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: PageView(
              controller: addZonesProvider.pageController,
              physics: const BouncingScrollPhysics(),
              children: const [AddZones(), LashVolume(), Bending()],
            ),
          )
        ],
      ),
    );
  }
}
