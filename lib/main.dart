// Dependencies
import 'package:flutter/material.dart';
// Widgets and Screens
import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('fr')],
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
        cardTheme: const CardTheme().copyWith(
          color: const Color.fromARGB(255, 243, 228, 251),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.deepPurple,
            backgroundColor: const Color.fromARGB(255, 211, 186, 252),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple,
              ),
            ),
      ),
      home: const Expenses(),
    );
  }
}
