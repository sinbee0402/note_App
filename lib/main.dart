import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/main/main_screen.dart';
import 'package:flutter_note_app/ui/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkGray),
        primaryColor: Colors.white,
        canvasColor: darkGray,
        //backgroundColor: darkGray,
        useMaterial3: true,
        floatingActionButtonTheme:
            Theme.of(context).floatingActionButtonTheme.copyWith(
                  backgroundColor: Colors.white,
                  foregroundColor: darkGray,
                ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: darkGray,
            ),
      ),
      home: const MainScreen(),
    );
  }
}
