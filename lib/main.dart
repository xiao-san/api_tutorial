import 'package:api_learn/splash_screen.dart';
import 'package:api_learn/view/home_screen.dart';
import 'package:api_learn/view/photo_screen.dart';
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
      home: const SplashScreen(),
      theme: ThemeData(
          drawerTheme: const DrawerThemeData(
          ),

          listTileTheme: const ListTileThemeData(
            textColor: Colors.white,
            iconColor: Color(0xffffcd02),
          ),

          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black, fontSize: 24),
          ),

        scaffoldBackgroundColor: Colors.black,
      ),

      
    );
  }
}
