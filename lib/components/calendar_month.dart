import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/utils.dart';

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({super.key});

  @override
  Widget build(BuildContext context) {
    const Map<CalendarFormat, String> availableCalendarFormats = {
      CalendarFormat.month: "Month"
    };

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 60)
          ],
          borderRadius: BorderRadius.circular(13)),
      child: TableCalendar(
        firstDay: DateTime(2021),
        lastDay: DateTime(2100),
        eventLoader: getEvents,
        focusedDay: DateTime.now(),
        availableCalendarFormats: availableCalendarFormats,
        locale: "ru_RU",
        calendarStyle: CalendarStyle(
            markerSize: 7,
            markersMaxCount: 1,
            markerDecoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(24)),
            markerMargin: const EdgeInsets.only(left: 20),
            todayDecoration: const BoxDecoration(color: Colors.white),
            todayTextStyle: const TextStyle(
                fontSize: 20,
                color: AppColors.secondary,
                fontWeight: FontWeight.w800),
            defaultTextStyle:
                const TextStyle(fontSize: 20, color: AppColors.primary),
            outsideTextStyle: TextStyle(
                fontSize: 20, color: AppColors.primary.withOpacity(0.3)),
            holidayTextStyle:
                const TextStyle(fontSize: 20, color: AppColors.primary),
            weekendTextStyle:
                const TextStyle(fontSize: 20, color: AppColors.primary)),
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (selectedDay, focusedDay) {
          openCalendarDay(context, selectedDay);
        },
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: headerTitleBuilder,
        ),
      ),
    );
  }

  Widget headerTitleBuilder(BuildContext context, DateTime day) {
    String headerMonth = DateFormat("MMMM", "ru").format(day).toString();
    String headerYear = DateFormat("yyyy", "ru").format(day).toString();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            headerMonth.toUpperCase(),
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 20,
            ),
          ),
          Text(
            " $headerYear",
            style: const TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List getEvents(DateTime day) {
    return List.generate(1, (index) => const Text("data"));
  }
}
