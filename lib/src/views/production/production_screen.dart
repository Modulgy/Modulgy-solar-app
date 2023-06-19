import 'package:flutter/material.dart';
import 'package:moduluenergy/generated/l10n.dart';
import 'package:moduluenergy/src/views/home/home_components.dart';
import 'package:moduluenergy/src/views/production/production_widgets.dart';

import '../../network/models.dart';
import '../../utils/app_colors.dart';

class ProductionScreen extends StatefulWidget {
  @override
  _ProductionScreenState createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
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
                // Section 1: Graph (placeholder, needs to be implemented)
                Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text("Graph Placeholder"),
                  ),
                ),

                // Section 2: Header title "Total" and 4 DashboardCards
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
                GridView.count(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.7,
                  crossAxisCount: 2,
                  children: [
                    DashboardCard(
                      title: Localized.of(context).total_energy,
                      dataValue: "100 kWh",
                      backgroundColor: AppColors.surfaceLightGray,
                      labelTextColor: AppColors.onSurfaceGray,
                      dataValueTextColor: Colors.black,
                      dataValueTextSize: 20,
                      hasElevation: false,
                    ),
                    DashboardCard(
                      title: Localized.of(context).consumption,
                      dataValue: "50 kWh",
                      backgroundColor: AppColors.surfaceLightGray,
                      labelTextColor: AppColors.onSurfaceGray,
                      dataValueTextColor: Colors.black,
                      dataValueTextSize: 20,
                      hasElevation: false,
                    ),
                    DashboardCard(
                      title: Localized.of(context).capacity,
                      dataValue: "75 kWh",
                      backgroundColor: AppColors.surfaceLightGray,
                      labelTextColor: AppColors.onSurfaceGray,
                      dataValueTextColor: Colors.black,
                      dataValueTextSize: 20,
                      hasElevation: false,
                    ),
                    DashboardCard(
                      title: Localized.of(context).co2_reduction,
                      dataValue: "20 kg",
                      backgroundColor: AppColors.surfaceLightGray,
                      labelTextColor: AppColors.onSurfaceGray,
                      dataValueTextColor: Colors.black,
                      dataValueTextSize: 20,
                      hasElevation: false,
                    ),
                  ],
                ),

                // Section 3: Header "Total Production per Day" and a list of elements
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
                ListView.separated(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5, // Dummy count for the example
                  itemBuilder: (BuildContext context, int index) {
                    return ProductionItem(
                      energyProduced: EnergyProduced(
                        date: "2021-01-0${index + 1}",
                        energyProduced: 100,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(color: Colors.grey.withOpacity(0.7));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
