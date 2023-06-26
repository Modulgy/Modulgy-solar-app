import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moduluenergy/main.dart';
import 'package:moduluenergy/src/network/api_provider.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/network/modulgy_article_service.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/utils/user_preferences.dart';
import 'package:moduluenergy/src/views/auth/login_components.dart';
import 'package:moduluenergy/src/views/home/chart_view.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
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
  return RefreshIndicator(
      child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            headerSection(context),
            graphAndCardsSection(),
            articlesSection(context),
          ])),
      onRefresh: () async {
        await getEnergyFromLastWeek();
      });
}

Widget graphAndCardsSection() {
  return FutureBuilder(
      future: getEnergyFromLastWeek(),
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
                  (snapshot.data as Success<List<EnergyProduced>>).data);
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
              child: const CircularProgressIndicator().marginOnly(top: 250));
        }
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
          child: WelcomeHeader(Localized.of(context).welcome_text,
                  Localized.of(context).app_introduction,
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
        Row(children: [
          Expanded(
              child: Text(Localized.current.energy_produced,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))),
          Text(Localized.current.weekly_text,
              style: const TextStyle(fontSize: 12, color: Colors.grey))
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
            title: Localized.current.electricity_cost,
            dataValue:
                "${(energyProducedThisWeek * costOfElectricity).toStringAsFixed(2)}€", // Replace with the actual data value
            periodValue: Localized.current.this_week,
            backgroundColor:
                Color(0xff7C53E5), // Customize the background color here
          ),
        ),
        const SizedBox(width: 16), // Adjust the spacing between cards as needed
        Expanded(
          child: DashboardCard(
            title: Localized.current.solar_energy_produced,
            dataValue: "${energyProducedThisWeek.toStringAsFixed(1)}KWh",
            // Replace with the actual data value
            periodValue: Localized.current.this_week,
            backgroundColor:
                const Color(0xffEC8C60), // Customize the background color here
          ),
        ),
      ],
    ),
  );
}

Widget articlesSection(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    padding: const EdgeInsets.all(16),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          Localized.current.total_energy,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      FutureBuilder<List<Article>>(
        future: getLatestArticles(),
        // Replace with your API call to fetch the list of articles
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Show an error message if data fetching fails
          } else if (!snapshot.hasData) {
            return const Text(
                'No Articles'); // Show a message if there is no data
          } else {
            final articles = snapshot.data ?? [];

            return Container(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ArticleWidget(article: article);
                  },
                ));
          }
        },
      ),
    ]),
  );
}

Future<List<Article>> getLatestArticles() async {
  var wordpressService = ModulgyApiProvider.instance.getWordpressService();
  return await wordpressService.getRecentArticles();
}

Future<Result> getEnergyData(EnergyTimeVisualization visualization, DateTime fromDate, DateTime toDate) async {
  await ModulgyApiProvider.instance.initAuthenticatedApiService();

  // Format the dates
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String from = dateFormat.format(fromDate);
  String to = dateFormat.format(toDate);

  String errorMessage = "";

  var energyResult = await ModulgyApiProvider.instance
      .getAPIService()
      .getMyEnergyProduction(visualization.name, from, to)
      .catchError((error) {
    switch (error.runtimeType) {
      case DioError:
        final dioError = error as DioError;
        final res = dioError.response;
        errorMessage = Localized.current.error_operation(
            res?.statusMessage?.toString() ?? "",
            dioError.error?.toString() ?? "");
        debugPrint(errorMessage);
        return null;
      default:
        return null;
    }
  });

  if (energyResult == null) {
    return Error(errorMessage);
  } else {
    debugPrint(energyResult.energyProduced.map((e) => e.energyProduced.toString()).join(","));
    return Success(energyResult.energyProduced);
  }
}

Future<Result> getEnergyFromLastWeek() async {
  DateTime now = DateTime.now();
  DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));
  return getEnergyData(EnergyTimeVisualization.DAY, sevenDaysAgo, now);
}

Future<Result> getEnergyFromLastMonth() async {
  DateTime now = DateTime.now();
  DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));
  return getEnergyData(EnergyTimeVisualization.DAY, thirtyDaysAgo, now);
}

Future<Result> getEnergyFromLastYear() async {
  DateTime now = DateTime.now();
  DateTime oneYearAgo = now.subtract(const Duration(days: 365));
  return getEnergyData(EnergyTimeVisualization.MONTH, oneYearAgo, now);
}

Future<Result> getEnergyForToday() async {
  DateTime now = DateTime.now();
  DateTime oneDayAgo = now.subtract(const Duration(days: 1));
  return getEnergyData(EnergyTimeVisualization.HOUR, oneDayAgo, now);
}

enum EnergyTimeVisualization { HOUR, DAY, MONTH }
