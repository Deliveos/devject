import 'package:flutter/material.dart';
import 'pages/add_project.dart';
import 'pages/login_page.dart';
import 'pages/main_page.dart';
import 'pages/register_page.dart';

Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (context) => const LoginPage(),
  RegisterPage.routeName: (context) => const RegisterPage(),
  MainPage.routeName: (context) => const MainPage(),
  AddProjectPage.routeName: (context) => const AddProjectPage()
};