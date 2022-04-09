import 'package:flutter/material.dart';

import 'theme_colors.dart';

final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  appBarTheme: _appBarTheme,
  textTheme: _textTheme,
);

const TextTheme _textTheme = TextTheme(
  //cards
  subtitle1: TextStyle(fontSize: 20, color: primaryColor),
  // word
  subtitle2: TextStyle(color: primaryColor, fontSize: 16),
  bodyText1: TextStyle(color: secondaryColor, fontSize: 15),
  bodyText2: TextStyle(
      fontSize: 15, color: subTitleColor),
//   bodyText2:
//   TextStyle(color: greyColor, fontSize: 15, fontWeight: FontWeight.bold),
//   button: TextStyle(
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//       color: Colors.white),
);

AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: colorAppBar,
    centerTitle: true,
    titleTextStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white));
