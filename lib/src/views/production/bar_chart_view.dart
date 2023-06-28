import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../network/models.dart';
import '../../utils/app_colors.dart';
import '../chart/chart_utils.dart';

class ProductionBarChart extends StatefulWidget {
  ProductionBarChart(this.energyProduced, this.selectedTimeMode, {super.key});

  List<EnergyProduced> energyProduced;
  TimeMode selectedTimeMode;

  @override
  State<ProductionBarChart> createState() => _ProductionBarChartState();
}

class _ProductionBarChartState extends State<ProductionBarChart> {
  List<Color> fgradientColors = [
    Color(0xff94303),
    Color(0xff94303).withOpacity(0.9),
  ];

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
            child: BarChart(
              mainData(widget.energyProduced),
            ),
          ),
        ),
      ],
    );
  }

  BarChartData mainData(List<EnergyProduced> energyProduced) {
    debugPrint("energyProduced: ${energyProduced.first.date}");
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

    return BarChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: TENTHS_CONSTANT.toDouble(),
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
            interval: 1,
            getTitlesWidget: titleWidgets,
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
      minY: isEmptyEnergy ? 0 : -5,
      maxY: max(maxEnergyEntry, 20),
      barGroups: flSpotEnergyProduced
          .map((entry) => makeGroupData(entry.x.toInt(), entry.y,
              width: widget.selectedTimeMode == TimeMode.WEEKLY
                  ? 11
                  : (100 / flSpotEnergyProduced.length) * 1.5))
          .toList(),
    );
  }
}

BarChartGroupData makeGroupData(
  int x,
  double y, {
  bool isTouched = false,
  Color? barColor,
  double width = 11,
  List<int> showTooltips = const [],
}) {
  debugPrint("MakeGroupData: $x, $y");
  barColor ??= AppColors.primaryColor;
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: isTouched ? y + 1 : y,
        color: barColor,
        width: width,
        borderSide: isTouched
            ? BorderSide(color: barColor.withOpacity(0.8))
            : const BorderSide(color: Colors.white, width: 0),
        backDrawRodData: BackgroundBarChartRodData(
          show: false,
          toY: 20,
          color: Colors.white,
        ),
      ),
    ],
    showingTooltipIndicators: showTooltips,
  );
}