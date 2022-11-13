import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../providers/custom_lash_provider.dart';
import '../../../utils/app_colors.dart';

class Bending extends StatelessWidget {
  const Bending({super.key});

  @override
  Widget build(BuildContext context) {
    final addZonesProvider = Provider.of<CustomLashProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 36),
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
                "ИЗГИБ",
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
          Visibility(
            visible: addZonesProvider.bendSettingMode == 0,
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children:
                  List.generate(addZonesProvider.bendSizes.length, (index) {
                return GestureDetector(
                  onTap: () {
                    addZonesProvider.setSelectedBend(index);
                  },
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: addZonesProvider.selectedBend == index
                          ? AppColors.secondary
                          : AppColors.primary,
                    ),
                    child: Center(
                      child: Text(
                        addZonesProvider.bendSizes[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    addZonesProvider.bendSettingMode == 1
                        ? addZonesProvider.setBendSettingMode(0)
                        : addZonesProvider.setBendSettingMode(1);
                  },
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: addZonesProvider.bendSettingMode == 1
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
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    addZonesProvider.bendSettingMode == 2
                        ? addZonesProvider.setBendSettingMode(0)
                        : addZonesProvider.setBendSettingMode(2);
                  },
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: addZonesProvider.bendSettingMode == 2
                          ? AppColors.secondary
                          : AppColors.primary,
                    ),
                    child: const Center(
                      child: FittedBox(
                        child: Text(
                          "РЯДНОСТЬ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: addZonesProvider.bendSettingMode == 1,
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
                              itemExtent: 48,
                              physics: const BouncingScrollPhysics(),
                              onSelectedItemChanged: (value) {
                                addZonesProvider.setCurrentBendSizes(
                                    index, value);
                                print(value);
                                addZonesProvider.setCustomBendValue(
                                    index, value);
                                print(addZonesProvider.customBendValues);
                                print(addZonesProvider.bendSizes);
                                print(addZonesProvider.currentBendSizes);
                              },
                              children: List.generate(
                                  addZonesProvider.bendSizes.length,
                                  (spinnerIndex) {
                                return RotatedBox(
                                    quarterTurns: 45,
                                    child: Text(
                                      addZonesProvider.bendSizes[spinnerIndex],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: spinnerIndex ==
                                                  addZonesProvider
                                                      .currentBendSizes[index]
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: spinnerIndex ==
                                                  addZonesProvider
                                                      .currentBendSizes[index]
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
          Visibility(
            visible: addZonesProvider.bendSettingMode == 2,
            child: Column(
              children:
                  List.generate(addZonesProvider.zoneValue.toInt(), (index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Column(
                        children: List.generate(3, (mode2Index) {
                          return SizedBox(
                            height: 60,
                            child: RotatedBox(
                              quarterTurns: -45,
                              child: ListWheelScrollView(
                                  itemExtent: 48,
                                  perspective: 0.005,
                                  physics: const BouncingScrollPhysics(),
                                  onSelectedItemChanged: (value) {
                                    addZonesProvider.setCurrentBendSizesMode2(
                                        index, mode2Index, value);
                                    addZonesProvider.seCustomBendValuesMode2(
                                        index, mode2Index, value);
                                  },
                                  children: List.generate(
                                      addZonesProvider.bendSizes.length,
                                      (spinnerIndex) {
                                    return RotatedBox(
                                        quarterTurns: 45,
                                        child: Text(
                                          addZonesProvider
                                              .bendSizes[spinnerIndex],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: spinnerIndex ==
                                                      addZonesProvider
                                                              .currentBendSizesMode2[
                                                          index][mode2Index]
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: spinnerIndex ==
                                                      addZonesProvider
                                                              .currentBendSizesMode2[
                                                          index][mode2Index]
                                                  ? Colors.black
                                                  : const Color(0xff858589)),
                                        ));
                                  })),
                            ),
                          );
                        }),
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
