import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/custom_lash_provider.dart';
import '../../../utils/app_colors.dart';

class Length extends StatelessWidget {
  const Length({super.key});

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
                "ДЛИНА",
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

          GestureDetector(
            onTap: () {
              addZonesProvider.updateIsLenghtRowEnabled();
            },
            child: Container(
              height: 31,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: addZonesProvider.isLenghtRowEnabled
                    ? AppColors.secondary
                    : AppColors.primary,
              ),
              child: const Center(
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "ВКЛЮЧИТЬ РЯДНОСТЬ РЕСНИЦ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !addZonesProvider.isLenghtRowEnabled,
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
                              addZonesProvider.setCurrentLengthSizes(
                                  index, value);
                              addZonesProvider.setCustomLengthValue(
                                  index, value);
                            },
                            children: List.generate(
                              addZonesProvider.lengthTextList.length,
                              (spinnerIndex) {
                                return RotatedBox(
                                  quarterTurns: 45,
                                  child: Text(
                                    addZonesProvider
                                        .lengthTextList[spinnerIndex]
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: spinnerIndex ==
                                              addZonesProvider
                                                  .currentLengthSizes[index]
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: spinnerIndex ==
                                              addZonesProvider
                                                  .currentLengthSizes[index]
                                          ? Colors.black
                                          : const Color(0xff858589),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Visibility(
            visible: addZonesProvider.isLenghtRowEnabled,
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
                                    addZonesProvider.setCurrentLengthSizesMode2(
                                        index, mode2Index, value);
                                    addZonesProvider.seCustomLengthValuesMode2(
                                        index, mode2Index, value);
                                  },
                                  children: List.generate(
                                      addZonesProvider.lengthTextList.length,
                                      (spinnerIndex) {
                                    return RotatedBox(
                                        quarterTurns: 45,
                                        child: Text(
                                          addZonesProvider
                                              .lengthTextList[spinnerIndex]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: spinnerIndex ==
                                                      addZonesProvider
                                                              .currentLengthSizesMode2[
                                                          index][mode2Index]
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: spinnerIndex ==
                                                      addZonesProvider
                                                              .currentLengthSizesMode2[
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
