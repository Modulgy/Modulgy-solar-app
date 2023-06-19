import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../network/models.dart';

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
            _dateFormat.format(_incomingDateFormat.parse(energyProduced.date)).capitalize(),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Right most side: Value label + "Wh" label
          Row(
            children: [
              Text(
                energyProduced.energyProduced.toStringAsFixed(0),
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
