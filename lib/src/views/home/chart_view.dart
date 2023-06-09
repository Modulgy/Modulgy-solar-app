import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../network/models.dart';

class EnergyChart extends StatefulWidget {
  EnergyChart(this.energyProduced, {super.key});

  List<EnergyProduced> energyProduced;

  @override
  State<EnergyChart> createState() => _EnergyChartState();
}

class _EnergyChartState extends State<EnergyChart> {
  List<Color> fgradientColors = [
    Color(0xff94303),
    Color(0xff94303).withOpacity(0.9),
  ];

  var mode = TimeMode.WEEKLY;
  static const int TENTHS_CONSTANT = 10;
  static const int HUNDREDTHS_CONSTANT = 100;

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(widget.energyProduced),
            ),
          ),
        ),
      ],
    );
  }

  Widget weeklyTitleWidgets(double value, TitleMeta meta) {
    debugPrint("value: $value");
    const style = TextStyle(
      color: Color(0xff979797),
      fontSize: 12,
    );

    final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final intValue = value ~/ 1.5;
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

  Widget monthlyTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff979797),
      fontSize: 12,
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

    String text = value % TENTHS_CONSTANT != 0 ? "" : "${value.toInt()}Wh";

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<EnergyProduced> energyProduced) {
    debugPrint("energyProduced: $energyProduced");
    var whEnergyProduced = energyProduced
        .map((e) => EnergyProduced(
            energyProduced: e.energyProduced * 1000, date: e.date))
        .toList();
    var maxEnergyEntry = whEnergyProduced
        .reduce((curr, next) =>
            curr.energyProduced > next.energyProduced ? curr : next)
        .energyProduced;
    var dateEntries =
        whEnergyProduced.map((e) => getDayOfWeek(e.date)).toList();
    debugPrint("dateEntries: $dateEntries");
    var indexOfBiggestDay = dateEntries.indexOf(7);
    debugPrint("indexOfBiggestDay: $indexOfBiggestDay");

    List<double> resultDateEntries = [];
    if (indexOfBiggestDay != dateEntries.length - 1) {
      var sublistBiggerThan7 =
          dateEntries.sublist(indexOfBiggestDay + 1).map((e) => e + 7).toList();
      debugPrint("sublistBiggerThan7: $sublistBiggerThan7");
      resultDateEntries =
          (dateEntries.sublist(0, indexOfBiggestDay) + [7] + sublistBiggerThan7)
              .map((e) => e * 1.5)
              .toList();
    }

    debugPrint(resultDateEntries.toString());
    var isEmptyEnergy = whEnergyProduced
    .map((e) => e.energyProduced)
    .toList()
    .every((element) => element == 0);

    //Let's put the energy in Wh
    var flSpotEnergyProduced = whEnergyProduced
        .mapIndexed((index, energy) =>
            FlSpot(resultDateEntries[index].toDouble(), energy.energyProduced))
        .toList();
    debugPrint("maxEnergyEntry: $maxEnergyEntry");
    debugPrint("flSpotEnergyProduced: $flSpotEnergyProduced");

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: TENTHS_CONSTANT.toDouble(),
        verticalInterval: 1.5,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xffD9D9D9),
            strokeWidth: 0.6,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xffD9D9D9),
            strokeWidth: 0.6,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            interval: 1.5,
            getTitlesWidget: mode == TimeMode.WEEKLY
                ? weeklyTitleWidgets
                : monthlyTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 32,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: null //Border.all(color: const Color(0xff37434d)),
          ),
      minX: findMinimum(resultDateEntries),
      maxX: findMaximum(resultDateEntries),
      minY: isEmptyEnergy ? 0 : -5,
      maxY: maxEnergyEntry,
      lineBarsData: [
        LineChartBarData(
          spots: flSpotEnergyProduced,
          isCurved: true,
          gradient: LinearGradient(
            colors: fgradientColors,
          ),
          barWidth: 6,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: fgradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

int getDayOfWeek(String dateString) {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime date = dateFormat.parse(dateString);
  return date.weekday;
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

  return list.reduce((current, next) => current.compareTo(next) < 0 ? current : next);
}

double findMaximum (List<double> list) {
  if (list.isEmpty) {
    throw Exception('The list is empty.');
  }

  return list.reduce((current, next) => current.compareTo(next) > 0 ? current : next);
}


enum TimeMode { WEEKLY, MONTHLY }
