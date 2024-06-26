import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:moduluenergy/main.dart';
import 'package:moduluenergy/src/network/api_provider.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/utils/app_colors.dart';
import 'package:moduluenergy/src/utils/spacing_extensions.dart';
import 'package:moduluenergy/src/utils/user_preferences.dart';
import 'package:moduluenergy/src/views/auth/auth_provider.dart';
import 'package:moduluenergy/src/views/auth/login_components.dart';
import 'package:moduluenergy/src/views/chart/chart_utils.dart';
import 'package:moduluenergy/src/views/home/chart_view.dart';
import 'package:intl/intl.dart';
import 'package:moduluenergy/src/views/production/production_screen.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../network/result.dart';
import '../../utils/app_styles.dart';
import 'home_components.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPeriodIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: BodyWidget(context),
    ));
  }

  Widget BodyWidget(BuildContext context) {
    return RefreshIndicator(
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              headerSection(context),
              graphAndCardsSection(_selectedPeriodIndex),
              articlesSection(context),
            ])),
        onRefresh: () async {
          await getEnergyForPeriod(_selectedPeriodIndex);
        });
  }

  Widget graphAndCardsSection(int selectedPeriod) {
    return FutureBuilder(
        future: getEnergyForPeriod(selectedPeriod),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(16),
                      child: Text("Error: ${snapshot.error}")));
            } else {
              if (snapshot.data is Success) {
                return dataSection(context, _selectedPeriodIndex, (int index) {
                  setState(() {
                    _selectedPeriodIndex = index;
                  });
                }, (snapshot.data as Success<List<EnergyProduced>>).data);
              } else {
                return Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(16),
                        child: Text(
                            "Error: ${(snapshot.data as Error).errorMessage}")));
              }
            }
          } else {
            return SizedBox(
                height: 300, child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)));
          }
        });
  }

  Widget dataSection(BuildContext context, int selectedPeriodList,
      Function(int) onPeriodSelected, List<EnergyProduced> energyData) {
    return Column(
      children: [
        graphSection(context, energyData, onPeriodSelected, selectedPeriodList)
            .marginBottom(5),
        cardsSection(energyData, selectedPeriodList)
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
                            context, ModulgyRoute.settings.getRoute())
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

  Widget dropdownPeriodSelector(
      BuildContext context, int selectedValue, Function(int) onPeriodChange) {
    final List<String> items = [
      Localized.of(context).day,
      Localized.of(context).week,
      Localized.of(context).month,
      Localized.of(context).year
    ];
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Text(
          'Select Period',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: items[selectedValue],
        onChanged: (String? value) {
          onPeriodChange(items.indexOf(value!));
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }

  Widget graphSection(BuildContext context, List<EnergyProduced> energyProduced,
      Function(int) onPeriodChange, int periodIndex) {
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
            dropdownPeriodSelector(context, periodIndex, onPeriodChange)
          ]),
          EnergyChart(
              energyProduced, getTimeModeForSelectedPeriod(periodIndex)),
        ],
      ),
    );
  }

  Widget cardsSection(List<EnergyProduced> energyProduced, int periodIndex) {
    //Placeholder value
    double costOfElectricity = 0.28;
    var energyProducedThisWeek = energyProduced.map((energy) {
      double number = double.parse(energy.energyProduced.toString());
      String formattedNumber = number.toStringAsFixed(20);
      print("Energy produced :" + energy.date + ' ' + formattedNumber.toString());
      return energy.energyProduced;
    }).fold<double>(0, (previousValue, element) => previousValue + element);
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
              periodValue: getDashboardCardLabelForPeriod(periodIndex),
              backgroundColor:
                  Color(0xff7C53E5), // Customize the background color here
            ),
          ),
          const SizedBox(width: 16),
          // Adjust the spacing between cards as needed
          Expanded(
            child: DashboardCard(
              title: Localized.current.solar_energy_produced,
              dataValue: shouldBeKWhUnit(energyProduced) ? "${energyProducedThisWeek.toStringAsFixed(1)}KWh" : "${energyProducedThisWeek.toStringAsFixed(1)}Wh",
              // Replace with the actual data value
              periodValue: getDashboardCardLabelForPeriod(periodIndex),
              backgroundColor: const Color(
                  0xffEC8C60), // Customize the background color here
            ),
          ),
        ],
      ),
    );
  }

  String getDashboardCardLabelForPeriod(int period) {
    switch (period) {
      case ProductionScreen.CONST_DAY_INDEX:
        return Localized.current.today;
      case ProductionScreen.CONST_WEEK_INDEX:
        return Localized.current.this_week;
      case ProductionScreen.CONST_MONTH_INDEX:
        return Localized.current.this_month;
      case ProductionScreen.CONST_YEAR_INDEX:
        return Localized.current.this_year;
      default:
        return Localized.current.this_week;
    }
  }

  Widget articlesSection(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(15,0,10,50),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Localized.current.articles_header,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ModulgyRoute.allArticles.getRoute());
                },
                child: Text(
                  Localized.current.see_all,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: ModulgyApp.primaryColor
                  ),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<List<Article>>(
          future: getLatestArticles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: 200,
                  child:  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: CircularProgressIndicator(color: AppColors.primaryColor,)))); // Show a loading indicator while fetching data
            } else if (snapshot.hasError) {
              return Text(Localized.current.error_loading_articles); // Show an error message if data fetching fails
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text(
                  Localized.current.no_articles); // Show a message if there is no data
            } else {
              final articles = snapshot.data ?? [];
              return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      if(articles.elementAtOrNull(index) == null) return null;
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
}

Future<Result> getEnergyData(EnergyTimeVisualization visualization,
    DateTime fromDate, DateTime toDate) async {
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
    debugPrint(energyResult.energyProduced
        .map((e) => e.energyProduced.toString())
        .join(","));
    List<EnergyProduced> energyList = [];
    energyResult.energyProduced.forEach((element) {
      // if(element.date == "2024-05-10 10:00:00") {
      //   EnergyProduced energyProduced = EnergyProduced(energyProduced: 100.0, date: element.date);
      //   energyList.add(energyProduced);
      //   return;
      // }
      EnergyProduced energyProduced = EnergyProduced(energyProduced: element.energyProduced * -1, date: element.date);
      energyList.add(energyProduced);
    });
    print(energyList.first.date);
    return Success(energyList);
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
  DateTime oneDayAgo = now.add(const Duration(days: 1));
  return getEnergyData(EnergyTimeVisualization.HOUR, now, oneDayAgo);
}

enum EnergyTimeVisualization { HOUR, DAY, MONTH }
