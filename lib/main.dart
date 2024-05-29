import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/network/mokodevice/moko_connection_provider.dart';
import 'package:moduluenergy/src/utils/app_colors.dart';
import 'package:moduluenergy/src/utils/app_styles.dart';
import 'package:moduluenergy/src/utils/user_preferences.dart';
import 'package:moduluenergy/src/views/articles/all_articles_screen.dart';
import 'package:moduluenergy/src/views/articles/article_screen.dart';
import 'package:moduluenergy/src/views/auth/activation_screen.dart';
import 'package:moduluenergy/src/views/auth/auth_provider.dart';
import 'package:moduluenergy/src/views/auth/forgot_password.dart';
import 'package:moduluenergy/src/views/auth/forgot_password_email.dart';
import 'package:moduluenergy/src/views/auth/login.dart';
import 'package:moduluenergy/src/views/auth/sign_up.dart';
import 'package:moduluenergy/src/views/auth/user_provider.dart';
import 'package:moduluenergy/src/views/home/home_screen.dart';
import 'package:moduluenergy/src/views/home/settings_screen.dart';
import 'package:moduluenergy/src/views/main_screen.dart';
import 'package:moduluenergy/src/views/production/production_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
import 'src/views/connect/connect_device.dart';

void main() {
  runApp(ModulgyApp());
}

class ModulgyApp extends StatelessWidget {
  ModulgyApp({super.key});

  static const MaterialColor primaryColor = MaterialColor(
    0xFFF94303,
    <int, Color>{
      50: Color(0xFFFFE9E5),
      100: Color(0xFFFFC7B8),
      200: Color(0xFFFFA08B),
      300: Color(0xFFFF784E),
      400: Color(0xFFFF5E27),
      500: Color(0xFFF94303),
      600: Color(0xFFD43703),
      700: Color(0xFFB02A02),
      800: Color(0xFF8A1D01),
      900: Color(0xFF6A1200),
    },
  );
  static const Color secondaryColor = Color(0xFF808D9E);
  static const Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    Future<UserData> getUserData() => UserPreferences().getUser();

    final tabs = [
      // list of widgets to be displayed when a tab is selected
      HomeScreen(),
      ProductionScreen()
    ];

    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? MultiProvider(
                providers: [
                    ChangeNotifierProvider(create: (_) => AuthProvider()),
                    ChangeNotifierProvider(create: (_) => UserProvider()),
                    ChangeNotifierProvider(
                        create: (_) => MokoConnectionProvider())
                  ],
                child: MaterialApp(
                  title: 'Modulgy',
                  debugShowCheckedModeBanner: false,
                  supportedLocales: Localized.delegate.supportedLocales,
                  localizationsDelegates: const [
                    Localized.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate
                  ],
                  theme: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: AppStyles.textFieldStyle,
                      hintStyle: AppStyles.textFieldStyle,
                    ),
                    fontFamily: GoogleFonts.urbanist().fontFamily,
                    primarySwatch: primaryColor,
                  ),
                  initialRoute: snapshot.data?.isValid() == true
                      ? ModulgyRoute.home.getRoute()
                      : ModulgyRoute.login.getRoute(),
                  routes: {
                    ModulgyRoute.login.getRoute(): (context) =>
                        const LoginScreen(),
                    ModulgyRoute.signup.getRoute(): (context) =>
                        const SignUpScreen(),
                    ModulgyRoute.forgotPasswordEmail.getRoute(): (context) =>
                        const ForgotPasswordEmailScreen(),
                    ModulgyRoute.forgotPassword.getRoute(): (context) =>
                        const ForgotPasswordScreen(
                          key: null,
                        ),
                    ModulgyRoute.activate.getRoute(): (context) =>
                        const ActivationCodeScreen(),
                    ModulgyRoute.home.getRoute(): (context) => MainScreen(),
                    ModulgyRoute.settings.getRoute(): (context) =>
                        const SettingsScreen(),
                    ModulgyRoute.connect.getRoute(): (context) =>
                        const ConnectDeviceScreen(),
                    ModulgyRoute.allArticles.getRoute(): (context) =>
                        const AllArticlesScreen(),
                  },
                ))
            : CircularProgressIndicator(color: AppColors.primaryColor,);
      },
    );
  }
}

enum ModulgyRoute {
  login,
  signup,
  activate,
  home,
  connect,
  forgotPasswordEmail,
  forgotPassword,
  settings,
  allArticles,
  article;

  String getRoute() {
    switch (this) {
      case ModulgyRoute.login:
        return '/${ModulgyRoute.login.name}';
      case ModulgyRoute.signup:
        return '/${ModulgyRoute.signup.name}';
      case ModulgyRoute.activate:
        return '/${ModulgyRoute.activate.name}';
      case ModulgyRoute.connect:
        return '/${ModulgyRoute.connect.name}';
      case ModulgyRoute.home:
        return '/${ModulgyRoute.home.name}';
      case ModulgyRoute.forgotPasswordEmail:
        return '/${ModulgyRoute.forgotPasswordEmail.name}';
      case ModulgyRoute.forgotPassword:
        return '/${ModulgyRoute.forgotPassword.name}';
      case ModulgyRoute.settings:
        return '/${ModulgyRoute.settings.name}';
      case ModulgyRoute.allArticles:
        return '/${ModulgyRoute.allArticles.name}';
      case ModulgyRoute.article:
        return '/${ModulgyRoute.article.name}';
      default:
        return '/${ModulgyRoute.login.name}';
    }
  }
}
