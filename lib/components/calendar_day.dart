import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/app_colors.dart';
import '../utils/utils.dart';

class CalendarDay extends StatefulWidget {
  final DateTime selectedDay;
  const CalendarDay({super.key, required this.selectedDay});

  @override
  State<CalendarDay> createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  final Map<CalendarFormat, String> availableCalendarFormats = {
    CalendarFormat.week: "Week"
  };
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    focusedDay = widget.selectedDay;
    selectedDay = widget.selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(0, 10),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 60)
      ], borderRadius: BorderRadius.circular(13)),
      child: TableCalendar(
        firstDay: DateTime(2021),
        lastDay: DateTime(2100),
        eventLoader: getEvents,
        availableCalendarFormats: availableCalendarFormats,
        currentDay: selectedDay,
        calendarFormat: CalendarFormat.week,
        focusedDay: focusedDay,
        locale: "ru_RU",
        calendarStyle: CalendarStyle(
            markerSize: 7,
            markersMaxCount: 1,
            markerDecoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(24)),
            markerMargin: const EdgeInsets.only(left: 20),
            todayDecoration: const BoxDecoration(
                color: AppColors.secondary, shape: BoxShape.circle),
            todayTextStyle: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800),
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
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = selectedDay;
          });
          print(focusedDay);
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
