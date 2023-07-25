import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/router.dart';
import 'package:flutter_note_app/di/di_setup.dart';
import 'package:flutter_note_app/ui/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkGray),
        unselectedWidgetColor: Colors.white,
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
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
            ),
      ),
    );
  }
}
