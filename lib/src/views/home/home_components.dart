import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String? dataValue;
  final String periodValue;
  final Color backgroundColor;

  final double dataValueTextSize;
  final double labelTextSize;

  final Color labelTextColor;
  final Color dataValueTextColor;

  final bool hasElevation;

  const DashboardCard({
    required this.title,
    this.dataValue,
    this.periodValue = "",
    required this.backgroundColor,
    this.dataValueTextSize = 24,
    this.labelTextSize = 16,
    this.labelTextColor = Colors.white,
    this.dataValueTextColor = Colors.white,
    this.hasElevation = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDataValueAvailable = dataValue != null && dataValue!.isNotEmpty;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: hasElevation ? 5 : 0,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: labelTextSize,
                fontWeight: FontWeight.bold,
                color: labelTextColor,
              ),
            ),
            const SizedBox(height: 8),
            isDataValueAvailable
                ? Text(
              dataValue!,
              style: TextStyle(
                fontSize: dataValueTextSize,
                fontWeight: FontWeight.bold,
                color: dataValueTextColor,
              ),
            )
                : const CircularProgressIndicator(),
              periodValue.isNotEmpty ?
              Text(
                periodValue,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ) : Container(height: 0,),
          ],
        ),
      ),
    );
  }
}
