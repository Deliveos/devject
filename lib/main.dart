import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projetex/pages/login_page.dart';
import 'package:projetex/pages/main_page.dart';
import 'package:projetex/pages/preloading%20pages/preloading_main_page.dart';
import 'package:projetex/routes.dart';
import 'package:projetex/themes/dark_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<void> checkToken (BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString("token") != null) {
        Navigator.pushNamed(context, MainPage.routeName);
      }
    }
    checkToken(context);
    return MaterialApp(
      title: 'ProjeteX',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home:  const PreloadingMainPage(),
      routes: routes,
    );
  }


}
