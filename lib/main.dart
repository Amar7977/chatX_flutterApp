import 'package:chatx/OnboardingScreen/Onboarding.dart';
import 'package:chatx/Theme/DarkTheme.dart';
import 'package:chatx/Theme/Light_Theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Light_Theme,
      darkTheme: Dark_Theme,
      home: Onboarding()
    );
  }
}

