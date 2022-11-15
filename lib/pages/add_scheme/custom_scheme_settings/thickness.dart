import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../providers/custom_lash_provider.dart';
import '../../../utils/app_colors.dart';

class Thickness extends StatelessWidget {
  const Thickness({super.key});

  @override
  Widget build(BuildContext context) {
    final addZonesProvider = Provider.of<CustomLashProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  addZonesProvider.goToPrevious();
                },
                icon: const Icon(Icons.chevron_left),
              ),
              const SizedBox(
                width: 24,
              ),
              const Text(
                "ТОЛЩИНА",
                style: TextStyle(color: AppColors.primary, fontSize: 24),
              ),
              const SizedBox(
                width: 24,
              ),
              IconButton(
                onPressed: () {
                  addZonesProvider.goToNext();
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          if (!addZonesProvider.isCustomSettingMode)
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    addZonesProvider.thicknessTextList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "${addZonesProvider.thicknessTextList[index]}",
                      style: TextStyle(
                        color: addZonesProvider.thicknessValue ==
                                addZonesProvider.thicknessTextList[index]
                            ? Colors.black
                            : const Color.fromARGB(255, 155, 155, 155),
                        fontSize: addZonesProvider.thicknessValue ==
                                addZonesProvider.thicknessTextList[index]
                            ? 28
                            : 22,
                      ),
                    ),
                  );
                }),
              ),
            ),
          if (!addZonesProvider.isCustomSettingMode)
            Slider(
              value: addZonesProvider.thicknessValue,
              activeColor: AppColors.secondary,
              min: 0.05,
              max: 0.15,
              inactiveColor: const Color(0xffcacaca),
              thumbColor: const Color(0xffeeeeee),
              onChanged: (value) {
                addZonesProvider.setThicknessValue(value);
              },
            ),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: () {
              addZonesProvider.updateIsCustomSettingMode();
            },
            child: Container(
              height: 31,
              width: 172,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: addZonesProvider.isCustomSettingMode
                    ? AppColors.secondary
                    : AppColors.primary,
              ),
              child: const Center(
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "РУЧНАЯ НАСТРОЙКА",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),

          Visibility(
            visible: addZonesProvider.isCustomSettingMode,
            child: Column(
              children:
                  List.generate(addZonesProvider.zoneValue.toInt(), (index) {
                return Row(
                  children: [
                    Container(
                      width: 120,
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: AppColors.primary),
                      child: Center(
                          child: Text(
                        "зона ${index + 1}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: RotatedBox(
                          quarterTurns: -45,
                          child: ListWheelScrollView(
                              itemExtent: 60,
                              physics: const BouncingScrollPhysics(),
                              onSelectedItemChanged: (value) {
                                addZonesProvider.setCurrentThicknessSizes(
                                    index, value);
                                addZonesProvider.setCustomThicknessValue(
                                    index, value);
                              },
                              children: List.generate(
                                  addZonesProvider.thicknessTextList.length,
                                  (spinnerIndex) {
                                return RotatedBox(
                                    quarterTurns: 45,
                                    child: Text(
                                      addZonesProvider
                                          .thicknessTextList[spinnerIndex]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: spinnerIndex ==
                                                  addZonesProvider
                                                          .currentThicknessSizes[
                                                      index]
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: spinnerIndex ==
                                                  addZonesProvider
                                                          .currentThicknessSizes[
                                                      index]
                                              ? Colors.black
                                              : const Color(0xff858589)),
                                    ));
                              })),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),

          //
        ],
      ),
    );
  }
}
