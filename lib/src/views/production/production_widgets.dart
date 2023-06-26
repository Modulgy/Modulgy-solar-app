import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../network/models.dart';
import '../../utils/app_colors.dart';

class ProductionItem extends StatelessWidget {
  EnergyProduced energyProduced;

  ProductionItem({super.key, required this.energyProduced});

  final DateFormat _dateFormat = DateFormat('EEEE d');
  final DateFormat _incomingDateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left most side: Label
          Text(
            _dateFormat
                .format(_incomingDateFormat.parse(energyProduced.date))
                .capitalize(),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Right most side: Value label + "Wh" label
          Row(
            children: [
              Text(
                (energyProduced.energyProduced * 1000).toStringAsFixed(0),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                "Wh",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PeriodSelector extends StatefulWidget {
  final Function(String) onPeriodSelected;

  const PeriodSelector({Key? key, required this.onPeriodSelected})
      : super(key: key);

  @override
  _PeriodSelectorState createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  String _selectedPeriod = 'Day';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      decoration: BoxDecoration(
        color: AppColors.surfaceLightGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['Day', 'Week', 'Month', 'Year'].map((period) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPeriod = period;
                widget.onPeriodSelected(period);
              });
            },
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    child: Text(
                      period,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedPeriod == period
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                    )),
                const SizedBox(height: 16),
                if (_selectedPeriod == period)
                  Container(
                    width: 40,
                    height: 2,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
