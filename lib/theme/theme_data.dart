import 'package:flutter/material.dart';

import 'theme_colors.dart';

final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  appBarTheme: _appBarTheme,
  textTheme: _textTheme,
);

const TextTheme _textTheme = TextTheme(
  subtitle1: TextStyle(fontSize: 20, color: primaryColor),
  subtitle2: TextStyle(color: primaryColor, fontSize: 16),
  bodyText1: TextStyle(color: secondaryColor, fontSize: 15),
  bodyText2: TextStyle(fontSize: 15, color: subTitleColor),
);

final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: colorAppBar,
    centerTitle: true,
    titleTextStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white));
