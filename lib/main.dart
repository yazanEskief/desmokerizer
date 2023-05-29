import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:desmokrizer/screens/home_screen.dart';

void main() {
  runApp(const App());
}

final appTheme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 64, 192, 87),
  ),
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: const Color.fromARGB(255, 64, 192, 87),
  ),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Desmokerizer",
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Desmokerizer",
            style: GoogleFonts.dancingScript(
              color: const Color.fromARGB(255, 235, 251, 238),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // backgroundColor: const Color.fromARGB(255, 64, 192, 87),
        ),
        body: const HomeScreen(),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [],
        // ),
      ),
    );
  }
}
