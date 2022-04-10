import 'package:flutter/material.dart';

final Color colorBG = Colors.grey.shade800;
final Color colorAppBar = Colors.grey.shade900;

const Color primaryColor = Colors.amberAccent;
const Color secondaryColor = Colors.white;
const Color subTitleColor = Colors.grey;
const Color cardColor = Colors.black26;
const Color errorColor = Colors.red;

final ColorScheme colorScheme = ColorScheme(
    background: colorBG,
    brightness: Brightness.dark,
    error: errorColor,
    secondary: secondaryColor,
    primary: primaryColor,
    surface: secondaryColor,
    onSurface: subTitleColor,
    onSecondary: secondaryColor,
    onPrimary: primaryColor,
    onBackground: colorBG,
    onError: secondaryColor);
