import 'package:flutter/material.dart';
import 'package:projetex/pages/login_page.dart';
import 'package:projetex/pages/main_page.dart';
import 'package:projetex/pages/register_page.dart';

Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (context) => const LoginPage(),
  RegisterPage.routeName: (context) => const RegisterPage(),
  MainPage.routeName: (context) => const MainPage()
};