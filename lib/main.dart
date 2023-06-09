import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:desmokrizer/screens/app_screen.dart';
import 'package:desmokrizer/screens/firstStepWizardScreens/loading_screen.dart';
import 'package:desmokrizer/screens/first_step_wizards_screen.dart';
import 'package:desmokrizer/provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late Future<void> isLoading;

  @override
  void initState() {
    isLoading = ref.read(userProvider.notifier).loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return MaterialApp(
      title: "Desmokerizer",
      theme: appTheme,
      home: FutureBuilder(
        future: isLoading,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }

          return user.isEmpty
              ? const FirstStepWizardsScreen()
              : const AppScreen();
        },
      ),
    );
  }
}
