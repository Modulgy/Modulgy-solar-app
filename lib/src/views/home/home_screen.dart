import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moduluenergy/main.dart';
import 'package:moduluenergy/src/network/api_provider.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/utils/user_preferences.dart';
import 'package:moduluenergy/src/views/auth/login_components.dart';
import 'package:moduluenergy/src/views/home/chart_view.dart';
import 'package:intl/intl.dart';

import '../../network/result.dart';
import '../../utils/app_styles.dart';
import 'home_components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(bottom: 32),
      child: BodyWidget(context),
    ));
  }
}

Widget BodyWidget(BuildContext context) {
  return RefreshIndicator(child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
            headerSection(context),
            FutureBuilder(
                future: getEnergyForLastWeek(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Expanded(
                          child: Container(
                              margin: const EdgeInsets.all(16),
                              child: Text("Error: ${snapshot.error}")));
                    } else {
                      if (snapshot.data is Success) {
                        return dataSection(
                            (snapshot.data as Success<List<EnergyProduced>>)
                                .data);
                      } else {
                        return Expanded(
                            child: Container(
                                margin: const EdgeInsets.all(16),
                                child: Text(
                                    "Error: ${(snapshot.data as Error).errorMessage}")));
                      }
                    }
                  } else {
                    return Center(
                        child:
                            const CircularProgressIndicator().marginOnly(top: 250));
                  }
                })
          ])),
      onRefresh: () async {
        await getEnergyForLastWeek();
      });
}

Widget dataSection(List<EnergyProduced> energyData) {
  return Column(
    children: [
      graphSection(energyData).marginBottom(16),
      cardsSection(energyData)
    ],
  );
}

Widget headerSection(BuildContext context) {
  return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 60, 8, 0),
      child: Row(children: [
        Expanded(
          flex: 6,
          child: WelcomeHeader("Welcome 👋", "Let's manage your smart solar",
                  headerStyle: AppStyles.dashboardHeadingStyle,
                  descriptionStyle: AppStyles.dashboardDescriptionStyle)
              .marginAll(16),
        ),
        Flexible(
            child: IconButton(
                onPressed: () => {
                      Navigator.pushNamed(
                          context, ModulgyRoute.connect.getRoute())
                    },
                icon: Icon(
                  Icons.settings,
                  size: 32,
                  color: Colors.black.withOpacity(0.5),
                ))),
        Flexible(
            child: IconButton(
                onPressed: () => {
                  UserPreferences().clearData(),
                  Navigator.popAndPushNamed(
                      context, ModulgyRoute.login.getRoute())
                },
                icon: Icon(
                  Icons.logout,
                  size: 32,
                  color: Colors.black.withOpacity(0.5),
                )))
      ]).marginBottom(16));
}

Widget graphSection(List<EnergyProduced> energyProduced) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Row(children: const [
          Expanded(
              child: Text("Energy Produced",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          Text("Weekly", style: TextStyle(fontSize: 12, color: Colors.grey))
        ]),
        EnergyChart(energyProduced),
      ],
    ),
  );
}

Widget cardsSection(List<EnergyProduced> energyProduced) {
  //Placeholder value
  double costOfElectricity = 0.28;

  var energyProducedThisWeek = energyProduced
      .map((energy) => energy.energyProduced)
      .fold<double>(0, (previousValue, element) => previousValue + element);
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: DashboardCard(
            title: 'Electricity\nCost',
            dataValue:
                "${(energyProducedThisWeek * costOfElectricity).toStringAsFixed(2)}€", // Replace with the actual data value
            periodValue: 'This Week',
            backgroundColor:
                Color(0xff7C53E5), // Customize the background color here
          ),
        ),
        const SizedBox(width: 16), // Adjust the spacing between cards as needed
        Expanded(
          child: DashboardCard(
            title: 'Solar Energy Produced',
            dataValue: "${energyProducedThisWeek.toStringAsFixed(1)}KWh",
            // Replace with the actual data value
            periodValue: 'This Week',
            backgroundColor:
                const Color(0xffEC8C60), // Customize the background color here
          ),
        ),
      ],
    ),
  );
}

Future<Result> getEnergyForLastWeek() async {
  await ModulgyApiProvider.instance.initAuthenticatedApiService();

  // Prepare the dates
  DateTime now = DateTime.now();
  DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

  // Format the dates
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String from = dateFormat.format(sevenDaysAgo);
  String to = dateFormat.format(now);

  String errorMessage = "";

  var energyResult = await ModulgyApiProvider.instance
      .getAPIService()
      .getMyEnergyProduction(EnergyTimeVisualization.DAY.name, from, to)
      .catchError((error) {
    switch (error.runtimeType) {
      case DioError:
        final dioError = error as DioError;
        final res = dioError.response;
        errorMessage =
            "Error during fetch ${res?.statusMessage ?? dioError.error?.toString()}";
        debugPrint(errorMessage);
        return null;
      default:
        return null;
    }
  });

  if (energyResult == null) {
    return Error(errorMessage);
  } else {
    return Success(energyResult.energyProduced);
  }
}

enum EnergyTimeVisualization { HOUR, DAY, MONTH }
