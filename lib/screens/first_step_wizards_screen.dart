import 'package:desmokrizer/screens/firstStepWizardScreens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstStepWizardsScreen extends StatefulWidget {
  const FirstStepWizardsScreen({super.key});

  @override
  State<FirstStepWizardsScreen> createState() => _FirstStepWizardsScreenState();
}

class _FirstStepWizardsScreenState extends State<FirstStepWizardsScreen> {
  void _start() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const UserInfo(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/first-step-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              "Desmokerizer",
              style: GoogleFonts.dancingScript(
                color: const Color.fromARGB(255, 235, 251, 238),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 300,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/first-slide-illustration.png"),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                "Let's get started by setting up your account. Click the button below to begin.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color.fromARGB(255, 37, 71, 117),
                      fontSize: 16,
                    ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton.icon(
              onPressed: _start,
              icon: const Icon(
                Icons.arrow_circle_right_outlined,
                size: 28,
              ),
              label: const Text(
                "Start",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
