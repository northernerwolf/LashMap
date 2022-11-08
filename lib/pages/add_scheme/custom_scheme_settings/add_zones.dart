import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/providers/custom_lash_provider.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:provider/provider.dart';

class AddZones extends StatelessWidget {
  const AddZones({super.key});

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
                "КОЛИЧЕСТВО ЗОН",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(15, (index) {
              if (index + 1 == addZonesProvider.zoneValue) {
                return Text(
                  "${index + 1}",
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
          Slider(
            value: addZonesProvider.zoneValue,
            activeColor: AppColors.secondary,
            min: 1,
            max: 15,
            divisions: 14,
            inactiveColor: const Color(0xffcacaca),
            thumbColor: const Color(0xffeeeeee),
            onChanged: (value) {
              addZonesProvider.setZoneValue(value);
            },
          ),
          Column(
            children:
                List.generate(addZonesProvider.zoneValue.toInt(), (index) {
              return FittedBox(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
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
                    Slider(
                      value: addZonesProvider.zoneValues[index],
                      activeColor: AppColors.secondary,
                      min: 0,
                      max: 15,
                      inactiveColor: const Color(0xffcacaca),
                      thumbColor: const Color(0xffeeeeee),
                      onChanged: (value) {
                        addZonesProvider.zoneValuesEnabled[index]
                            ? addZonesProvider.setZoneValues(index, value)
                            : null;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        addZonesProvider.updateZoneValuesEnabled(index);
                      },
                      child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color(0xffebebeb), width: 1)),
                          child: Icon(
                            Icons.lock_outline,
                            color: addZonesProvider.zoneValuesEnabled[index]
                                ? AppColors.secondary
                                : AppColors.primary,
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
