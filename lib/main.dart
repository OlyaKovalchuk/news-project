import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projects/auth/screen/intro_screen.dart';
import 'package:projects/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: themeData,
    debugShowCheckedModeBanner: false,
    home: IntroScreen(),
  ));
}
