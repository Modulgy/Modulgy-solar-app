import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moduluenergy/generated/l10n.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/views/home/home_components.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class AllArticlesScreen extends StatefulWidget {
  const AllArticlesScreen({super.key});

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
  Future<List<dynamic>> getLatestArticles() async {
    //var wordpressService = ModulgyApiProvider.instance.getWordpressService();
    //return await wordpressService.getRecentArticles();

    const Map<String, dynamic>? _data = null;
    final dio = Dio();

    Response response = await dio.fetch(Options(
      method: 'GET',
    ).compose(
      BaseOptions(
        validateStatus: (status) {
          print("estado $status");
          return true;
        },
      ),
      'https://www.modulgy.com/wp-json/wp/v2/posts?_embed',
    ));
    print(response);
    var value = response.data!.map((dynamic i) {
      return Article.fromJson(i as Map<String, dynamic>);
    }).toList();
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: AppColors.primaryColor,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          )),
      title: Text(
        Localized.current.articles,
        style: AppStyles.dashboardHeadingStyle.copyWith(color: Colors.white),
      ),
      centerTitle: true,
    ), body: BodyWidget(context),);
  }

  Widget BodyWidget(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: getLatestArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: double.infinity,
              child:  Center(
                  child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: CircularProgressIndicator(color: AppColors.primaryColor,))));
        } else if (snapshot.hasData) {
          List<dynamic> articles = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            child: GridView.builder(
              physics: const PageScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 15),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleWidget(article: articles[index]);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(Localized.current.error_loading_articles));
        } else {
          return Center(child: Text(Localized.current.no_articles));
        }
      },
    );
  }
}
