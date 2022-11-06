import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/custom_lash_provider.dart';
import '../../../utils/app_colors.dart';

class LashVolume extends StatelessWidget {
  const LashVolume({super.key});

  @override
  Widget build(BuildContext context) {
    final addZonesProvider = Provider.of<CustomLashProvider>(context);

    return SingleChildScrollView(
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
                "ОБЪЕМ",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(8, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  index.floor().isOdd
                      ? "${addZonesProvider.volumeTextList[index].toInt()}"
                      : "${addZonesProvider.volumeTextList[index]}",
                  style: TextStyle(
                    color: addZonesProvider.volumeValue ==
                            addZonesProvider.volumeTextList[index]
                        ? Colors.black
                        : const Color.fromARGB(255, 155, 155, 155),
                    fontSize: addZonesProvider.volumeValue ==
                            addZonesProvider.volumeTextList[index]
                        ? 28
                        : 22,
                  ),
                ),
              );
            }),
          ),
          Slider(
            value: addZonesProvider.volumeValue,
            activeColor: AppColors.secondary,
            min: 0.5,
            max: 4,
            divisions: 7,
            inactiveColor: const Color(0xffcacaca),
            thumbColor: const Color(0xffeeeeee),
            onChanged: (value) {
              addZonesProvider.setVolumeValue(value);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              addZonesProvider.updateIsBlack();
            },
            child: Container(
              width: double.infinity,
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 48),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: addZonesProvider.isBlack
                      ? AppColors.secondary
                      : AppColors.primary),
              child: const Center(
                child: Text("ЧЕРНЫЕ",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              addZonesProvider.updateIsBlack();
            },
            child: Container(
              width: double.infinity,
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 48),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: addZonesProvider.isBlack
                      ? AppColors.primary
                      : AppColors.secondary),
              child: const Center(
                child: Text("КОРИЧНЕВЫЕ",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
