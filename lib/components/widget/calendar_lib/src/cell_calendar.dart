import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calendar_event.dart';
import 'components/days_of_the_week.dart';
import 'components/days_row/days_row.dart';
import 'components/month_year_label.dart';
import 'controllers/calendar_state_controller.dart';
import 'controllers/cell_calendar_page_controller.dart';
import 'controllers/cell_height_controller.dart';
import 'date_extension.dart';

typedef daysBuilder = Widget Function(int dayIndex);

typedef monthYearBuilder = Widget Function(DateTime? visibleDateTime);

class TodayUIConfig {
  final Color todayMarkColor;
  final Color todayTextColor;

  TodayUIConfig(this.todayTextColor, this.todayMarkColor);
}

/// Calendar widget like a Google Calendar
///
/// Expected to be used in full screen
// ignore: must_be_immutable
class CellCalendar extends StatelessWidget {
  CellCalendar(
      {this.cellCalendarPageController,
      this.events = const [],
      this.onPageChanged,
      this.onCellTapped,
      this.todayMarkColor = Colors.blue,
      this.todayTextColor = Colors.white,
      this.daysOfTheWeekBuilder,
      this.monthYearLabelBuilder,
      this.dateTextStyle,
      this.currentDate});

  final CellCalendarPageController? cellCalendarPageController;
  DateTime? currentDate;

  /// Builder to show days of the week labels
  ///
  /// 0 for Sunday, 6 for Saturday.
  /// By default, it returns English labels
  final daysBuilder? daysOfTheWeekBuilder;

  final monthYearBuilder? monthYearLabelBuilder;

  final TextStyle? dateTextStyle;

  final List<CalendarEvent> events;
  final void Function(DateTime firstDate, DateTime lastDate)? onPageChanged;
  final void Function(DateTime)? onCellTapped;
  final Color todayMarkColor;
  final Color todayTextColor;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CalendarStateController(
            events: events,
            onPageChangedFromUserArgument: onPageChanged,
            onCellTappedFromUserArgument: onCellTapped,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CellHeightController(),
        ),
        Provider.value(value: TodayUIConfig(todayTextColor, todayMarkColor)),
      ],
      child: _CalendarPageView(daysOfTheWeekBuilder, monthYearLabelBuilder,
          dateTextStyle, cellCalendarPageController, currentDate!),
    );
  }
}

/// Shows [MonthYearLabel] and PageView of [_CalendarPage]
class _CalendarPageView extends StatelessWidget {
  _CalendarPageView(this.daysOfTheWeekBuilder, this.monthYearLabelBuilder,
      this.dateTextStyle, this.cellCalendarPageController, this.currentDate);
  final DateTime currentDate;
  final daysBuilder? daysOfTheWeekBuilder;
  final monthYearBuilder? monthYearLabelBuilder;
  final TextStyle? dateTextStyle;
  final CellCalendarPageController? cellCalendarPageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MonthYearLabel(monthYearLabelBuilder),
        Expanded(
          child: PageView.builder(
            controller:
                cellCalendarPageController ?? CellCalendarPageController(),
            itemBuilder: (context, index) {
              return _CalendarPage(index.visibleDateTime, daysOfTheWeekBuilder,
                  currentDate, dateTextStyle);
            },
            onPageChanged: (index) {
              Provider.of<CalendarStateController>(context, listen: false)
                  .onPageChanged(index);
            },
          ),
        ),
      ],
    );
  }
}

/// Page of [_CalendarPage]
///
/// Wrapped with [CalendarMonthController]
class _CalendarPage extends StatelessWidget {
  const _CalendarPage(
    this.visiblePageDate,
    this.daysOfTheWeekBuilder,
    this.currentDate,
    this.dateTextStyle, {
    Key? key,
  }) : super(key: key);

  final DateTime visiblePageDate;
  final DateTime? currentDate;
  final daysBuilder? daysOfTheWeekBuilder;
  final TextStyle? dateTextStyle;

  List<DateTime> _getCurrentDays(DateTime dateTime) {
    final List<DateTime> result = [];
    final firstDay = _getFirstDay(dateTime);
    result.add(firstDay);
    for (int i = 0; i + 1 < 42; i++) {
      result.add(firstDay.add(Duration(days: i + 1)));
    }
    return result;
  }

  DateTime _getFirstDay(DateTime dateTime) {
    final firstDayOfTheMonth = DateTime(dateTime.year, dateTime.month, 1);
    return firstDayOfTheMonth.add(firstDayOfTheMonth.weekday.daysDuration);
  }

  @override
  Widget build(BuildContext context) {
    final days = _getCurrentDays(visiblePageDate);

    return Container(
      child: Column(
        children: [
          DaysOfTheWeek(daysOfTheWeekBuilder),
          Container(
            height: 780,
            child: ListView.builder(
                itemCount: 6,
                padding: EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 130,
                    child: DaysRow(
                        visiblePageDate: visiblePageDate,
                        dates:
                            days.getRange(index * 7, (index + 1) * 7).toList(),
                        dateTextStyle: dateTextStyle,
                        currentDate: currentDate!),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
