import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/custom_lash_provider.dart';
import '../../../utils/app_colors.dart';

class Rays extends StatelessWidget {
  const Rays({super.key});

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
                "ЛУЧИКИ",
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
              addZonesProvider.updateIsRaysEnabled();
            },
            child: Container(
              height: 31,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: addZonesProvider.isRaysEnabled
                    ? AppColors.secondary
                    : AppColors.primary,
              ),
              child: const Center(
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "ВКЛЮЧИТЬ СЛОЙ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          if (addZonesProvider.isRaysEnabled)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(13, (index) {
                if (index + 3 == addZonesProvider.rayValue) {
                  return Text(
                    "${index + 3}",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 78, 78, 78), fontSize: 24),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: Color(0xff88888c),
                    ),
                  );
                }
              }),
            ),
          if (addZonesProvider.isRaysEnabled)
            Slider(
              value: addZonesProvider.rayValue.toDouble(),
              activeColor: AppColors.secondary,
              min: 3,
              max: 15,
              divisions: 14,
              inactiveColor: const Color(0xffcacaca),
              thumbColor: const Color(0xffeeeeee),
              onChanged: (value) {
                addZonesProvider.setRayValue(value.toInt());
              },
            ),
          Visibility(
            visible: addZonesProvider.isRaysEnabled,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: AppColors.primary),
                      child: const Center(
                          child: Text(
                        "ИЗГИБ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                                addZonesProvider.setRayBendValue(
                                    addZonesProvider.bendSizes[value]);
                              },
                              children: List.generate(
                                  addZonesProvider.bendSizes.length,
                                  (spinnerIndex) {
                                return RotatedBox(
                                    quarterTurns: 45,
                                    child: Text(
                                      addZonesProvider.bendSizes[spinnerIndex]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: addZonesProvider
                                                          .bendSizes[
                                                      spinnerIndex] ==
                                                  addZonesProvider.rayBendValue
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: addZonesProvider.bendSizes[
                                                      spinnerIndex] ==
                                                  addZonesProvider.rayBendValue
                                              ? Colors.black
                                              : const Color(0xff858589)),
                                    ));
                              })),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: AppColors.primary),
                      child: const Center(
                          child: Text(
                        "ТОЛЩИНА",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                                addZonesProvider.setRayThicknessValue(
                                    addZonesProvider.thicknessTextList[value]);
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
                                          fontWeight: addZonesProvider
                                                          .thicknessTextList[
                                                      spinnerIndex] ==
                                                  addZonesProvider.rayThickness
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: addZonesProvider
                                                          .thicknessTextList[
                                                      spinnerIndex] ==
                                                  addZonesProvider.rayThickness
                                              ? Colors.black
                                              : const Color(0xff858589)),
                                    ));
                              })),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: AppColors.primary),
                      child: const Center(
                          child: Text(
                        "ДЛИНА +",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                              addZonesProvider.setRayLengthValue(
                                  addZonesProvider.lengthTextList[value]);
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
                                        fontWeight:
                                            addZonesProvider.lengthTextList[
                                                        spinnerIndex] ==
                                                    addZonesProvider.rayLength
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        color: addZonesProvider.lengthTextList[
                                                    spinnerIndex] ==
                                                addZonesProvider.rayLength
                                            ? Colors.black
                                            : const Color(0xff858589)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "* к основной длине",
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.grey),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
