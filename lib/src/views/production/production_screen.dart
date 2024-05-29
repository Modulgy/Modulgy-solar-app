import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:moduluenergy/generated/l10n.dart';
import 'package:moduluenergy/main.dart';
import 'package:moduluenergy/src/views/home/home_components.dart';
import 'package:moduluenergy/src/views/home/home_screen.dart';
import 'package:moduluenergy/src/views/production/bar_chart_view.dart';
import 'package:moduluenergy/src/views/production/production_widgets.dart';
import '../../network/models.dart';
import '../../network/result.dart';
import '../../utils/app_colors.dart';
import '../chart/chart_utils.dart';

class ProductionScreen extends StatefulWidget {
  @override
  _ProductionScreenState createState() => _ProductionScreenState();

  static var co2ReductionConstant = 0.384;
  static const CONST_DAY_INDEX = 0;
  static const CONST_WEEK_INDEX = 1;
  static const CONST_MONTH_INDEX = 2;
  static const CONST_YEAR_INDEX = 3;
}

class _ProductionScreenState extends State<ProductionScreen> {
  int _selectedPeriodIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> periodsList = [
      Localized.of(context).day,
      Localized.of(context).week,
      Localized.of(context).month,
      Localized.of(context).year
    ];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement the logic to refresh the data.
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Section 0: Header title "Production"
                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 20, left: 12),
                  child: Text(
                    Localized.of(context).production,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PeriodSelector(
                      onPeriodSelected: (period) {
                        setState(() {
                          _selectedPeriodIndex = period;
                        });
                      },
                    )),
                // Section 1: Graph (placeholder, needs to be implemented)
                energyDataSectionPerPeriod(context, _selectedPeriodIndex),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: productionPerDaySection(context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget energyDataSectionPerPeriod(BuildContext context, int selectedPeriod) {
  return FutureBuilder(
      future: getEnergyForPeriod(selectedPeriod),
      builder: (context, snapshot) {
        print(snapshot.data);
        List<EnergyProduced> energyProduced = [];
        ProductionLoadingState loadingState = snapshot.hasData &&
            snapshot.connectionState != ConnectionState.waiting
            ? ProductionLoadingState.loaded
            : snapshot.hasError
            ? ProductionLoadingState.error
            : ProductionLoadingState.loading;
        if(snapshot.hasData) {
          if(snapshot.data is Error) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              getGraphForLoadingState(loadingState, selectedPeriod, energyProduced),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20),
                child: Text(
                  Localized.of(context).total_energy,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: getCardsForLoadingState(
                      context, loadingState, energyProduced))
            ]);
          }
          energyProduced =
          snapshot.hasData && !snapshot.hasError
              ? (snapshot.data as Success<List<EnergyProduced>>).data ?? []
              : [];
        }

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          getGraphForLoadingState(loadingState, selectedPeriod, energyProduced),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20),
            child: Text(
              Localized.of(context).total_energy,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: getCardsForLoadingState(
                  context, loadingState, energyProduced))
        ]);
      });
}

Widget productionBarChart(
    List<EnergyProduced> energyProduced, TimeMode selectedTimeMode) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ProductionBarChart(energyProduced, selectedTimeMode));
}

Widget cardsSection(BuildContext context, List<EnergyProduced> energyProduced) {
  var totalEnergyForPeriod = energyProduced.isNotEmpty ? energyProduced
      .map((energy) => energy.energyProduced)
      .reduce((value, element) => value + element) : 0;

  return GridView.count(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 1.6,
    crossAxisCount: 2,
    children: [
      DashboardCard(
        title: Localized.of(context).total_energy,
        dataValue: "${totalEnergyForPeriod.toStringAsFixed(1)}KWh",
        backgroundColor: AppColors.surfaceLightGray,
        labelTextColor: AppColors.onSurfaceGray,
        dataValueTextColor: Colors.black,
        dataValueTextSize: 20,
        hasElevation: false,
      ),
      DashboardCard(
        title: Localized.of(context).co2_reduction,
        dataValue:
            "${getCarbonEmissionSaving(totalEnergyForPeriod.toInt()).toStringAsFixed(0)} kg",
        backgroundColor: AppColors.surfaceLightGray,
        labelTextColor: AppColors.onSurfaceGray,
        dataValueTextColor: Colors.black,
        dataValueTextSize: 20,
        hasElevation: false,
      ),
    ],
  );
}

Widget productionPerDaySection(BuildContext context) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        Localized.of(context).total_production_per_day,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
    FutureBuilder(
        future: getEnergyFromLastWeek(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is Success) {
              var energyProducedResult =
                  (snapshot.data as Success<List<EnergyProduced>>).data;
              return ListView.separated(
                  reverse: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: energyProducedResult.length,
                  // Dummy count for the example
                  itemBuilder: (BuildContext context, int index) {
                    return ProductionItem(
                      energyProduced: energyProducedResult[index],
                      isInKWh: shouldBeKWhUnit(energyProducedResult),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(color: Colors.grey.withOpacity(0.7));
                  });
            } else {
              return Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Text(
                          "Error: ${(snapshot.data as Error).errorMessage}")));
            }
          } else {
            return SizedBox(
                height: 200,
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ))));
          }
        })
  ]);
}

Widget getGraphForLoadingState(ProductionLoadingState loadingState,
    int selectedPeriod, List<EnergyProduced> energyProduced) {
  switch (loadingState) {
    case ProductionLoadingState.loading:
      return SizedBox(
          height: 200,
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  )))); // Show a loading indicator while fetching data
    case ProductionLoadingState.error:
      return const Text(
          'Error retrieving energy data'); // Show a message if there is no data
    case ProductionLoadingState.loaded:
      return productionBarChart(
          energyProduced,
          getTimeModeForSelectedPeriod(
              selectedPeriod)); // Show a message if there is no data
    default:
      return SizedBox(
          height: 200,
          child: Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ))); // Show a message if there is no data
  }
}

Widget getCardsForLoadingState(BuildContext context,
    ProductionLoadingState loadingState, List<EnergyProduced> energyProduced) {
  switch (loadingState) {
    case ProductionLoadingState.loading:
      return SizedBox(
          height: 200,
          child: Center(
              child:
              CircularProgressIndicator(color: AppColors.primaryColor,))); // Show a loading indicator while fetching data
    case ProductionLoadingState.error:
      return const Text(
          'Error retrieving energy data'); // Show a message if there is no data
    case ProductionLoadingState.loaded:
      return cardsSection(
          context, energyProduced); // Show a message if there is no data
    default:
      return SizedBox(
          height: 200,
          child: Center(
              child:
  CircularProgressIndicator(color: AppColors.primaryColor,))); // Show a message if there is no data
  }
}

Future<Result> getEnergyForPeriod(int period) {
  switch (period) {
    case ProductionScreen.CONST_DAY_INDEX:
      return getEnergyForToday();
    case ProductionScreen.CONST_WEEK_INDEX:
      return getEnergyFromLastWeek();
    case ProductionScreen.CONST_MONTH_INDEX:
      return getEnergyFromLastMonth();
    case ProductionScreen.CONST_YEAR_INDEX:
      return getEnergyFromLastYear();
    default:
      return getEnergyFromLastWeek();
  }
}

TimeMode getTimeModeForSelectedPeriod(int selectedPeriod) {
  debugPrint("Selected period: $selectedPeriod");
  switch (selectedPeriod) {
    case ProductionScreen.CONST_DAY_INDEX:
      return TimeMode.HOURLY;
    case ProductionScreen.CONST_WEEK_INDEX:
      return TimeMode.WEEKLY;
    case ProductionScreen.CONST_MONTH_INDEX:
      return TimeMode.MONTHLY;
    case ProductionScreen.CONST_YEAR_INDEX:
      return TimeMode.MONTHLY;
    default:
      return TimeMode.WEEKLY;
  }
}

int getCarbonEmissionSaving(int energyProduced) {
  return (energyProduced * ProductionScreen.co2ReductionConstant).round();
}

enum ProductionLoadingState { loading, loaded, error }
