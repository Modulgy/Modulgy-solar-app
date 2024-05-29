import 'dart:ffi';
import 'dart:ui';

import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moduluenergy/src/utils/app_colors.dart';
import 'package:moduluenergy/src/views/articles/article_screen.dart';
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
            builder: (context) => ArticleScreen(
              article: article,
            ),
          ),
        );
      },
      child: Container(
        width: 150, // Fixed width
        height: 250, // Fixed height, adjust as needed
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: Colors.black)
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: article.featuredMediaUrl.isNotEmpty
                      ? Image.network(
                            article.featuredMediaUrl,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print(stackTrace);
                              return Container(
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE8E8E8),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.error_outline,
                                  color: AppColors.primaryColor,
                                )),
                              );
                            },
                          )
                      : Container(
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8E8E8),
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.error_outline,
                            color: AppColors.primaryColor,
                          )),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  article.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
