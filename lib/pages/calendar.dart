import 'package:flutter/material.dart';
import 'package:lash_map/components/calendar_item.dart';
import 'package:lash_map/utils/app_colors.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final List<GlobalKey> _key = List.generate(12, (index) => GlobalKey());
  int currentMonthIndex = DateTime.now().month - 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                offset: const Offset(1, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25))
          ]),
          padding: const EdgeInsets.only(top: 47, bottom: 12),
          child: const Center(
            child: Text(
              "КАЛЕНДАРЬ",
              style: TextStyle(color: AppColors.primary, fontSize: 24),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CalendarMonth(),
      ],
    );
  }

  Future scrollToCurrentMonth() async {
    await Scrollable.ensureVisible(_key[currentMonthIndex].currentContext!,
        duration: const Duration(seconds: 1));
  }
}
