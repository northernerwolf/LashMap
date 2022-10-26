import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lash_map/utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMonth extends StatelessWidget {
  final int month;
  const CalendarMonth({super.key, required this.month});

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
        firstDay: DateTime(2022, month),
        lastDay: DateTime(2022, month + 1, 0),
        focusedDay: DateTime(2022, month + 1, 0),
        availableCalendarFormats: availableCalendarFormats,
        availableGestures: AvailableGestures.none,
        locale: "ru_RU",
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: const HeaderStyle(
            leftChevronVisible: false, rightChevronVisible: false),
        calendarBuilders: CalendarBuilders(
            headerTitleBuilder: headerTitleBuilder,
            disabledBuilder: disabledBuilder,
            todayBuilder: (context, day, focusedDay) {
              return Text(
                focusedDay.day.toString(),
                style: const TextStyle(color: AppColors.primary, fontSize: 20),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              return Text(
                day.day.toString(),
                style: const TextStyle(color: AppColors.primary, fontSize: 20),
              );
            }),
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

  Widget? disabledBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return Visibility(
      visible: false,
      child: Text(
        day.day.toString(),
      ),
    );
  }
}
