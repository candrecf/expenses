import 'package:flutter/material.dart';
import 'package:fluttersnippet2/route/home_route.dart';
// import 'package:flutter/services.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    // SystemChrome.setPreferredOrientations(
    //   [DeviceOrientation.portraitUp],
    // );

    return MaterialApp(
      home: const HomePage(),
      theme: tema.copyWith(
        primaryColor: Colors.purple,
        colorScheme: tema.colorScheme.copyWith(
          primary: const Color.fromARGB(255, 183, 91, 200),
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headlineSmall: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          color: Colors.purple,
          titleTextStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
