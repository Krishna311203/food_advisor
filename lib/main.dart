import 'package:flutter/material.dart';
import 'package:food_advisor/features/Auth/pages/signup_screen.dart';
import 'package:food_advisor/features/Home/pages/home_screen.dart';
import 'package:food_advisor/features/Ocr/pages/scan_screen.dart';
import 'package:food_advisor/features/splash/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => SignupScreen(),
          '/home': (context) => HomeScreen(),
          '/scan': (context) => ScanScreen(),
        });
  }
}
