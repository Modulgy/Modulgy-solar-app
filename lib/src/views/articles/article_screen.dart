import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moduluenergy/generated/l10n.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/utils/app_colors.dart';
import 'package:moduluenergy/src/utils/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key, required this.article});

  final Article article;

  final String testContent = '''<html>
  <body>
  <figure class="table"><table>
  <thead>
  <tr>
  <th>Ano</th>
  <th>Previsão de Resíduos (toneladas métricas)</th>
  </tr>
  </thead>
  <tbody>
  <tr>
  <td>2020</td>
  <td>250.000</td>
  </tr>
  <tr>
  <td>2030</td>
  <td>6.000.000</td>
  </tr>
  <tr>
  <td>2040</td>
  <td>30.000.000</td>
  </tr>
  <tr>
  <td>2050</td>
  <td>80.000.000</td>
  </tr>
  </tbody>
  </table>
  </body>
  </html></figure>''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(onTap: () {
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back_rounded, color: Colors.white,)),
        title: Text(
          article.title,
          style: AppStyles.dashboardHeadingStyle.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          print(article.link);
          if (!await launchUrl(Uri.parse(article.link))) {
            throw Exception('Could not launch ${article.link}');
          }
        },
        label: Text(
          Localized.of(context).open_article_in_browser,
          style: AppStyles.authDescriptionStyle.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: RawScrollbar(
          interactive: true,
          radius: const Radius.circular(8),
          thumbColor: AppColors.primaryColor,
          thumbVisibility: true,
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 80),
                child: Html(
                  shrinkWrap: true,
                  extensions: const [TableHtmlExtension()],
                  data:
                      "<img src='${article.featuredMediaUrl}'> <h1>${article.title}</h1> ${article.content}",
                  style: Style.fromCss(
                      "blockquote { background-color: #E8E8E8; border-left: 10px solid #F83419; margin: 1.5em 10px; padding: 0.5 10px;}"
                      "h1 { font-size: 30; }"
                      "h2 { font-size: 26; }"
                      "h3 { font-size: 22; }"
                      "p, a, li { font-size: 16; }"
                      "a { color: #c36; }"
                      "a { color: #c36; }"
                      "* { text-decoration-color: #c36; }"
                      "table{background-color:transparent;margin-block-end:15px;font-size:16px;border-spacing:0;border-collapse:collapse}"
                      "table td,table th{padding:15px;line-height:1.5px;vertical-align:top;border:1px solid hsla(0,0%,50.2%,.5019607843)}"
                      "table th{font-weight:700}"
                      "table tfoot th,table thead th{font-size:16px}",
                      (css, errors) => null),
                  onAnchorTap: (url, attributes, element) async {
                    print(url);
                    if (!await launchUrl(Uri.parse(url!))) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  onLinkTap: (url, attributes, element) async {
                    print(url);
                    if (!await launchUrl(Uri.parse(url!))) {
                      throw Exception('Could not launch $url');
                    }
                  },
                ),
              )),
        ),
      ),
    );
  }
}
