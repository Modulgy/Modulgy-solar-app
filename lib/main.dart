import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moduluenergy/src/network/models.dart';
import 'package:moduluenergy/src/network/mokodevice/moko_connection_provider.dart';
import 'package:moduluenergy/src/utils/app_styles.dart';
import 'package:moduluenergy/src/utils/user_preferences.dart';
import 'package:moduluenergy/src/views/auth/activation_screen.dart';
import 'package:moduluenergy/src/views/auth/auth_provider.dart';
import 'package:moduluenergy/src/views/auth/login.dart';
import 'package:moduluenergy/src/views/auth/sign_up.dart';
import 'package:moduluenergy/src/views/auth/user_provider.dart';
import 'package:moduluenergy/src/views/home/home_screen.dart';
import 'package:provider/provider.dart';

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

    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {

        debugPrint("userData: ${snapshot.data?.email ?? "null"}");
        return snapshot.hasData ? MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => MokoConnectionProvider())
            ],
            child: MaterialApp(
              title: 'Modulenergy',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: AppStyles.textFieldStyle,
                  hintStyle: AppStyles.textFieldStyle,
                ),
                fontFamily: GoogleFonts.urbanist().fontFamily,
                primarySwatch: primaryColor,
              ),
              initialRoute: snapshot.data?.isValid() == true ? ModulgyRoute.home.getRoute() : ModulgyRoute.login.getRoute(),
              routes: {
                ModulgyRoute.login.getRoute(): (context) => const LoginScreen(),
                ModulgyRoute.signup.getRoute(): (context) => const SignUpScreen(),
                ModulgyRoute.activate.getRoute(): (context) =>
                const ActivationCodeScreen(),
                ModulgyRoute.home.getRoute(): (context) => HomeScreen(),
                ModulgyRoute.connect.getRoute(): (context) =>
                const ConnectDeviceScreen(),
              },
            )) : const CircularProgressIndicator();
      },
    );
  }
}

enum ModulgyRoute {
  login,
  signup,
  activate,
  home,
  connect;

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
      default:
        return '/${ModulgyRoute.login.name}';
    }
  }
}
