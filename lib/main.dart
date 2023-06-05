import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import 'package:desmokrizer/models/user.dart';
import 'package:desmokrizer/screens/chat_screen.dart';
import 'package:desmokrizer/screens/galery_screen.dart';
import 'package:desmokrizer/screens/health_screen.dart';
import 'package:desmokrizer/screens/savings_screen.dart';
import 'package:desmokrizer/screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 64, 192, 87),
  background: const Color.fromARGB(255, 235, 251, 238),
);

final appTheme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: const Color.fromARGB(255, 64, 192, 87),
      iconTheme: const IconThemeData().copyWith(color: Colors.white)),
  textTheme: GoogleFonts.aBeeZeeTextTheme().copyWith(
    bodyMedium: GoogleFonts.aBeeZeeTextTheme().bodyMedium!.copyWith(
          color: const Color.fromARGB(255, 73, 80, 87),
        ),
  ),
);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Widget _activeScreen = const HomeScreen();
  int _currentIndex = 2;

  Color _activebottomNavButtomColor(isActive) {
    return isActive
        ? const Color.fromARGB(255, 64, 192, 87)
        : const Color.fromARGB(255, 235, 251, 238);
  }

  void _changeScreen(index) {
    setState(() {
      _currentIndex = index;

      if (_currentIndex == 0) {
        _activeScreen = const SavingsScreen();
      }
      if (_currentIndex == 1) {
        _activeScreen = const HealthScreen();
      }
      if (_currentIndex == 2) {
        _activeScreen = const HomeScreen();
      }
      if (_currentIndex == 3) {
        _activeScreen = const ChatScreen();
      }
      if (_currentIndex == 4) {
        _activeScreen = const GaleryScreen();
      }
    });
  }

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
        ),
        body: _activeScreen,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: const Color.fromARGB(255, 64, 192, 87),
            items: [
              BottomNavigationBarItem(
                backgroundColor: const Color.fromARGB(223, 5, 5, 5),
                icon: Icon(
                  _currentIndex == 0 ? Icons.savings : Icons.savings_outlined,
                  color: _activebottomNavButtomColor(_currentIndex == 0),
                ),
                label: "Savings",
              ),
              BottomNavigationBarItem(
                backgroundColor: const Color.fromARGB(223, 5, 5, 5),
                icon: Icon(
                  _currentIndex == 1
                      ? Icons.heart_broken
                      : Icons.heart_broken_outlined,
                  color: _activebottomNavButtomColor(_currentIndex == 1),
                ),
                label: "Health",
              ),
              BottomNavigationBarItem(
                backgroundColor: const Color.fromARGB(223, 5, 5, 5),
                icon: Icon(
                  _currentIndex == 2 ? Icons.home : Icons.home_outlined,
                  color: _activebottomNavButtomColor(_currentIndex == 2),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                backgroundColor: const Color.fromARGB(223, 5, 5, 5),
                icon: Icon(
                  _currentIndex == 3
                      ? Icons.chat_bubble
                      : Icons.chat_bubble_outline,
                  color: _activebottomNavButtomColor(_currentIndex == 3),
                ),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                backgroundColor: const Color.fromARGB(223, 5, 5, 5),
                icon: Icon(
                  _currentIndex == 4
                      ? Icons.camera_alt
                      : Icons.camera_alt_outlined,
                  color: _activebottomNavButtomColor(_currentIndex == 4),
                ),
                label: "Galery",
              ),
            ],
            onTap: _changeScreen),
      ),
    );
  }
}
