import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../network/models.dart';
import '../home/chart_view.dart';

int getDayOfWeek(String dateString) {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime date = dateFormat.parse(dateString);
  return date.weekday;
}

int getMonthOfYear(String dateString) {
  debugPrint("getMonthOfYear: $dateString");
  DateFormat dateFormat = DateFormat('yyyy-MM');
  DateTime date = dateFormat.parse(dateString);
  return date.month;
}

int getHourOfDay(String dateString) {
  debugPrint("getHourOfDay: $dateString");
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime date = dateFormat.parse(dateString);
  return date.hour;
}

int getDayOfMonth(String dateString) {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime date = dateFormat.parse(dateString);
  return date.day;
}

List<EnergyProduced> parseEnergyInWhOrKWh(List<EnergyProduced> inputList) {
  int lessThanOneCount = 0;
  for (EnergyProduced element in inputList) {
    if (element.energyProduced < 1) {
      lessThanOneCount++;
    }
  }

  if (lessThanOneCount > inputList.length / 2) {
    return inputList
        .map((element) => EnergyProduced(
            energyProduced: element.energyProduced * 1000, date: element.date))
        .toList();
  } else {
    return inputList;
  }
}

bool shouldBeKWhUnit(List<EnergyProduced> inputList) {
  int lessThanOneCount = 0;
  for (EnergyProduced element in inputList) {
    if (element.energyProduced < 1) {
      lessThanOneCount++;
    }
  }

  if (lessThanOneCount > inputList.length / 2) {
    return false;
  } else {
    return true;
  }
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) f) {
    var index = 0;
    return map((element) => f(index++, element));
  }
}

double findMinimum(List<double> list) {
  if (list.isEmpty) {
    throw Exception('The list is empty.');
  }

  return list
      .reduce((current, next) => current.compareTo(next) < 0 ? current : next);
}

double findMaximum(List<double> list) {
  if (list.isEmpty) {
    throw Exception('The list is empty.');
  }

  return list
      .reduce((current, next) => current.compareTo(next) > 0 ? current : next);
}

List<int> parseDailyDate(List<EnergyProduced> whEnergyProduced) {
  return whEnergyProduced.map((e) => getHourOfDay(e.date)).toList();
}

List<int> parseMonthlyDate(List<EnergyProduced> whEnergyProduced) {
  debugPrint(whEnergyProduced.length.toString());
  return whEnergyProduced
      .map((e) => whEnergyProduced.length > 13
          ? getDayOfMonth(e.date)
          : getMonthOfYear(e.date))
      .toList();
}

List<int> parseWeeklyDate(List<EnergyProduced> whEnergyProduced) {
  var dateEntries = whEnergyProduced.map((e) => getDayOfWeek(e.date)).toList();
  var indexOfBiggestDay = dateEntries.indexOf(7);

  List<int> resultDateEntries = [];
  if (indexOfBiggestDay != dateEntries.length - 1) {
    var sublistBiggerThan7 =
        dateEntries.sublist(indexOfBiggestDay + 1).map((e) => e + 7).toList();
    debugPrint("sublistBiggerThan7: $sublistBiggerThan7");
    resultDateEntries =
        (dateEntries.sublist(0, indexOfBiggestDay) + [7] + sublistBiggerThan7);
    /*.map((e) => e * 1.5)
              .toList();*/
    return resultDateEntries;
  } else {
    return dateEntries;
  }
}

Widget weeklyTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff979797),
    fontSize: 12,
  );
  debugPrint("x: ${value.toInt()}");

  final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  final intValue = value.toInt();
  final parsedIntValue = intValue > 7 ? intValue - 7 : intValue;
  Widget text;

  if (parsedIntValue >= 1 && parsedIntValue <= weekdays.length) {
    text = Text(weekdays[parsedIntValue - 1], style: style);
  } else {
    text = const Text('', style: style);
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget dailyTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff979797),
    fontSize: 10,
  );
  return Text(value.toStringAsFixed(0), style: style);
}

Widget daysOfMonthTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff979797),
    fontSize: 10,
  );
  if (value % 2 != 0) {
    return const Text('');
  } else {
    return Text(value.toStringAsFixed(0), style: style);
  }
}

Widget monthlyTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff979797),
    fontSize: 10,
  );

  final months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  final intValue = value.toInt();
  Widget text;

  if (intValue >= 1 && intValue <= months.length) {
    text = Text(months[intValue - 1], style: style);
  } else {
    text = const Text('', style: style);
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff979797),
    fontSize: 12,
  );

  String text = value % EnergyChart.HORIZONTAL_CONSTANT != 0 ? "" : "${value.toInt()} Wh";

  return Text(text, style: style, textAlign: TextAlign.left);
}

const int TENTHS_CONSTANT = 10;
const int HUNDREDTHS_CONSTANT = 100;

enum TimeMode { HOURLY, WEEKLY, MONTHLY }
