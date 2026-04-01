import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const KctiApp());
}

class KctiApp extends StatelessWidget {
  const KctiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KCTI 경영기획본부 통계',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A3A5C),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'sans-serif',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A3A5C),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
