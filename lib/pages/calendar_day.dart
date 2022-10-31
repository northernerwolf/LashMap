import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lash_map/components/calendar_day.dart';
import 'package:lash_map/components/calendar_month.dart';

import '../utils/app_colors.dart';
import 'add_event.dart';
import 'add_new_client.dart';

class CalendarDayPage extends StatelessWidget {
  final DateTime selectedDay;
  const CalendarDayPage({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                offset: const Offset(1, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25))
          ]),
          padding: const EdgeInsets.only(top: 47, bottom: 12),
          child: Column(
            children: [
              const SizedBox(
                height: 47,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "КАЛЕНДАРЬ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.primary, fontSize: 24),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => const AddEventPage(),
                            ),
                          )
                          .then((value) {});
                    },
                    child: const Icon(
                      CupertinoIcons.add_circled_solid,
                      size: 29,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CalendarDay(
                selectedDay: selectedDay,
              )
            ],
          ),
        ),
      ],
    ));
  }
}