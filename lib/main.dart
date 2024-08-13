import 'package:api_learn/home_screen.dart';
import 'package:api_learn/photo_screen.dart';
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
      home: const HomeScreen(),
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

        // scaffoldBackgroundColor: Colors.black,
      ),

      
    );
  }
}
