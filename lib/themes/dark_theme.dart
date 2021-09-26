import 'package:flutter/material.dart';
import 'package:projetex/constants/colors.dart';

final ThemeData darkTheme = ThemeData(
  primaryColor: kPrimaryLightColor,
  dividerTheme: const DividerThemeData(
      color: kPrimaryDarkColor
    ),
    textTheme: const TextTheme(
      subtitle1: TextStyle(
        color: kTextColor,
        fontSize: 18.0
      ),
      subtitle2: TextStyle(
        color: kTextColor,
        fontSize: 14.0
      ),
      bodyText1: TextStyle(
        color: kTextColor,
        fontSize: 14.0,
      ),
      bodyText2: TextStyle(
        color: kPrimaryLightColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w700
      ),
      caption: TextStyle(
        color: kTextColor,
        fontSize: 36.0,
        fontWeight: FontWeight.w700
      ),
      button: TextStyle(
        color: kTextColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w700
      ),
      headline2: TextStyle(
        color: kTextColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600
      ),
      headline4: TextStyle(
        color: kTextColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
      headline6: TextStyle(
        fontSize: 16.0,
        fontFamily: "NotoColorEmoji"
      ),
    )
);