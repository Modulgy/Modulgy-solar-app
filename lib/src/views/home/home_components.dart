import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moduluenergy/src/views/home/web_view_screen.dart';

import '../../network/models.dart';

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
            periodValue.isNotEmpty
                ? Text(
                    periodValue,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  )
                : Container(
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  final Article article;

  ArticleWidget({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: article.link, title: article.title,),
            ),
          );
        },
        child: Container(
          width: 150,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.all(Radius.circular(16.0)),
                child: Image.network(
                  headers: const {'Accept': '*/*'},
                  article.featuredMediaUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
