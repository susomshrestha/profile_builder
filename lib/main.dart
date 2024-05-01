import 'package:flutter/material.dart';
import 'package:profile_builder/pages/onboarding.dart';
import 'package:profile_builder/themes/dark_theme.dart';
import 'package:profile_builder/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Onboarding(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}