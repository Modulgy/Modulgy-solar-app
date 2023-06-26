import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moduluenergy/generated/l10n.dart';
import 'package:moduluenergy/src/views/home/home_components.dart';
import 'package:moduluenergy/src/views/home/home_screen.dart';
import 'package:moduluenergy/src/views/production/bar_chart_view.dart';
import 'package:moduluenergy/src/views/production/production_widgets.dart';

import '../../network/models.dart';
import '../../network/result.dart';
import '../../utils/app_colors.dart';

class ProductionScreen extends StatefulWidget {
  @override
  _ProductionScreenState createState() => _ProductionScreenState();

  static var co2ReductionConstant = 0.384;
}

class _ProductionScreenState extends State<ProductionScreen> {
  String _selectedPeriod = 'Day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement the logic to refresh the data.
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Section 0: Header title "Production"
                const Padding(
                  padding: EdgeInsets.only(top: 60, bottom: 20),
                  child: Text(
                    "Production",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                PeriodSelector(
                  onPeriodSelected: (period) {
                    setState(() {
                      _selectedPeriod = period;
                    });
                  },
                ),
                // Section 1: Graph (placeholder, needs to be implemented)
                energyDataSectionPerPeriod(context, _selectedPeriod),
                productionPerDaySection(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget energyDataSectionPerPeriod(BuildContext context, String selectedPeriod) {
  return FutureBuilder(
      future: getEnergyForPeriod(selectedPeriod),
      builder: (context, snapshot) {
        List<EnergyProduced> energyProduced = snapshot.hasData
            ? (snapshot.data as Success<List<EnergyProduced>>).data
            : [];
        ProductionLoadingState loadingState = snapshot.hasData &&
                snapshot.connectionState != ConnectionState.waiting
            ? ProductionLoadingState.loaded
            : snapshot.hasError
                ? ProductionLoadingState.error
                : ProductionLoadingState.loading;
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          getGraphForLoadingState(loadingState, energyProduced),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              Localized.of(context).total_energy,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          getCardsForLoadingState(context, loadingState, energyProduced)
        ]);
      });
}

Widget mainProductionSection(BuildContext context, bool hasData, bool hasError,
    List<EnergyProduced> energyProduced) {
  return Column(
    children: [
      !hasData
          ? const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()))
          : productionBarChart(energyProduced, TimeMode.WEEKLY),
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          Localized.of(context).total_energy,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      hasData
          ? cardsSection(context, energyProduced)
          : const SizedBox(
              height: 200, child: Center(child: CircularProgressIndicator()))
    ],
  );
}

Widget productionBarChart(
    List<EnergyProduced> energyProduced, TimeMode selectedTimeMode) {
  return Padding(
      padding: const EdgeInsets.all(8),
      child: ProductionBarChart(energyProduced, selectedTimeMode));
}

Widget cardsSection(BuildContext context, List<EnergyProduced> energyProduced) {
  var totalEnergyForPeriod = energyProduced
      .map((energy) => energy.energyProduced)
      .reduce((value, element) => value + element);

  return GridView.count(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    childAspectRatio: 1.7,
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
      /*DashboardCard(
                      title: Localized.of(context).consumption,
                      dataValue: "50 kWh",
                      backgroundColor: AppColors.surfaceLightGray,
                      labelTextColor: AppColors.onSurfaceGray,
                      dataValueTextColor: Colors.black,
                      dataValueTextSize: 20,
                      hasElevation: false,
                    ),*/
      /*DashboardCard(
                      title: Localized.of(context).capacity,
                      dataValue: "75 kWh",
                      backgroundColor: AppColors.surfaceLightGray,
                      labelTextColor: AppColors.onSurfaceGray,
                      dataValueTextColor: Colors.black,
                      dataValueTextSize: 20,
                      hasElevation: false,
                    ),*/
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
  return Column(children: [
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
            return const Center(child: CircularProgressIndicator());
          }
        })
  ]);
}

Widget getGraphForLoadingState(
    ProductionLoadingState loadingState, List<EnergyProduced> energyProduced) {
  switch (loadingState) {
    case ProductionLoadingState.loading:
      return const SizedBox(
          height: 200,
          child: Center(
              child:
                  CircularProgressIndicator())); // Show a loading indicator while fetching data
    case ProductionLoadingState.error:
      return const Text(
          'Error retrieving energy data'); // Show a message if there is no data
    case ProductionLoadingState.loaded:
      return productionBarChart(energyProduced, TimeMode.WEEKLY); // Show a message if there is no data
    default:
      return const SizedBox(
          height: 200,
          child: Center(
              child:
                  CircularProgressIndicator())); // Show a message if there is no data
  }
}

Widget getCardsForLoadingState(BuildContext context,
    ProductionLoadingState loadingState, List<EnergyProduced> energyProduced) {
  switch (loadingState) {
    case ProductionLoadingState.loading:
      return const SizedBox(
          height: 200,
          child: Center(
              child:
                  CircularProgressIndicator())); // Show a loading indicator while fetching data
    case ProductionLoadingState.error:
      return const Text(
          'Error retrieving energy data'); // Show a message if there is no data
    case ProductionLoadingState.loaded:
      return cardsSection(
          context, energyProduced); // Show a message if there is no data
    default:
      return const SizedBox(
          height: 200,
          child: Center(
              child:
                  CircularProgressIndicator())); // Show a message if there is no data
  }
}

Future<Result> getEnergyForPeriod(String period) {
  switch (period) {
    case 'Day':
      return getEnergyForToday();
    case 'Week':
      return getEnergyFromLastWeek();
    case 'Month':
      return getEnergyFromLastMonth();
    case 'Year':
      return getEnergyFromLastYear();
    default:
      return getEnergyFromLastWeek();
  }
}

int getCarbonEmissionSaving(int energyProduced) {
  return (energyProduced * ProductionScreen.co2ReductionConstant).round();
}

enum ProductionLoadingState { loading, loaded, error }
