import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../network/models.dart';
import '../chart/chart_utils.dart';

class EnergyChart extends StatefulWidget {
  EnergyChart(this.energyProduced, this.selectedTimeMode, {super.key});

  List<EnergyProduced> energyProduced;
  TimeMode selectedTimeMode;
  static int HORIZONTAL_CONSTANT = 10;

  @override
  State<EnergyChart> createState() => _EnergyChartState();
}

class _EnergyChartState extends State<EnergyChart> {
  List<Color> fgradientColors = [
    Color(0xff94303),
    Color(0xff94303).withOpacity(0.9),
  ];

  var mode = TimeMode.WEEKLY;

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

  LineChartData mainData(List<EnergyProduced> energyProduced) {
    var shouldBeKWh = shouldBeKWhUnit(energyProduced);
    var parsedProducedEnergy = parseEnergyInWhOrKWh(energyProduced)
        .toList();
    var maxEnergyEntry = parsedProducedEnergy
        .reduce((curr, next) =>
    curr.energyProduced > next.energyProduced ? curr : next)
        .energyProduced;

    List<int> resultDateEntries = [];
    switch (widget.selectedTimeMode) {
      case TimeMode.WEEKLY:
        resultDateEntries = parseWeeklyDate(parsedProducedEnergy);
        break;
      case TimeMode.HOURLY:
        resultDateEntries = parseDailyDate(parsedProducedEnergy);
        break;
      case TimeMode.MONTHLY:
        resultDateEntries = parseMonthlyDate(parsedProducedEnergy);
        break;
    }

    debugPrint("resultDateEntries: ${resultDateEntries.toString()}");
    var isEmptyEnergy = parsedProducedEnergy
        .map((e) => e.energyProduced)
        .toList()
        .every((element) => element == 0);

    //Let's put the energy in Wh
    var flSpotEnergyProduced = parsedProducedEnergy
        .mapIndexed((index, energy) =>
        FlSpot(resultDateEntries[index].toDouble(), energy.energyProduced))
        .toList();
    debugPrint("maxEnergyEntry: $maxEnergyEntry");
    debugPrint("flSpotEnergyProduced: $flSpotEnergyProduced");

    var titleWidgets = monthlyTitleWidgets;
    switch (widget.selectedTimeMode) {
      case TimeMode.WEEKLY:
        titleWidgets = weeklyTitleWidgets;
        break;
      case TimeMode.HOURLY:
        titleWidgets = dailyTitleWidgets;
        break;
      case TimeMode.MONTHLY:
        titleWidgets = energyProduced.length > 13
            ? daysOfMonthTitleWidgets
            : monthlyTitleWidgets;
        break;
    }

    EnergyChart.HORIZONTAL_CONSTANT = max(divideAndRoundToClosestMultipleOfTen(maxEnergyEntry.toInt()), TENTHS_CONSTANT);

    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map(
                  (LineBarSpot touchedSpot) {
                const textStyle = TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                );
                return LineTooltipItem(
                  "${parsedProducedEnergy[touchedSpot.spotIndex].energyProduced.toStringAsFixed(2)} ${shouldBeKWh ? "kWh" : "Wh"}",
                  textStyle,
                );
              },
            ).toList();
          },
        ),
        getTouchedSpotIndicator: (LineChartBarData barData,
            List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.blueGrey.withOpacity(0.8),
                strokeWidth: 0,
              ),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 7,
                    strokeWidth: 0,
                    color: Colors.blueGrey,
                  );
                },
              ),
            );
          }).toList();
        },
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: EnergyChart.HORIZONTAL_CONSTANT.toDouble(),
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
            getTitlesWidget: titleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 48,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: null //Border.all(color: const Color(0xff37434d)),
          ),
      minX: findMinimum(resultDateEntries.map((e) => e.toDouble()).toList()),
      maxX: findMaximum(resultDateEntries.map((e) => e.toDouble()).toList()),
      minY: isEmptyEnergy ? 0 : -5,
      maxY: max(maxEnergyEntry, 20),
      lineBarsData: [
        LineChartBarData(
          spots: flSpotEnergyProduced,
          preventCurveOverShooting: true,
          preventCurveOvershootingThreshold: 5.0,
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
int divideAndRoundToClosestMultipleOfTen(int value) {
  int result = value ~/ 5;
  int closestMultipleOfTen = result - (result % 10);
  return closestMultipleOfTen;
}
