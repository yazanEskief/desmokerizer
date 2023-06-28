import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/main.dart';
import 'package:desmokrizer/models/user.dart';

class SmokingCosts extends ConsumerStatefulWidget {
  const SmokingCosts({
    super.key,
    required this.userInfo,
  });

  final Map<String, dynamic> userInfo;

  @override
  ConsumerState<SmokingCosts> createState() => _SmokingCostsState();
}

class _SmokingCostsState extends ConsumerState<SmokingCosts> {
  final formKey = GlobalKey<FormState>();
  var _cigarettesPack = 0.0;
  var _packPrice = 0.0;
  var _smokedCiagrettesPerDay = 0.0;
  var _cigarettesInPack = 0.0;

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final user = User(
        name: widget.userInfo["name"],
        localImage: widget.userInfo["image"],
        start: widget.userInfo["start"],
        cigarettesPacks: _cigarettesPack,
        packPrice: _packPrice,
        smokedCigarettesPerDay: _smokedCiagrettesPerDay,
        cigarettesInPack: _cigarettesInPack,
      );

      ref.read(userProvider.notifier).setUser(user, widget.userInfo["image"]);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const App(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Smoking costs",
          style: TextStyle(
            color: Color.fromARGB(255, 235, 251, 238),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/smoking-costs.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                "Smoking hurts your wallet as well",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 37, 71, 117),
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return "This is field is mandatory";
                  }
                  if (double.parse(value) <= 0.0) {
                    return "can't be zero or negative";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _cigarettesPack = double.parse(newValue!);
                },
                decoration: InputDecoration(
                  hintText: "How many packs do you smoke each day",
                  labelText: "Cigarettes packs",
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return "This is field is mandatory";
                  }
                  if (double.parse(value) <= 0.0) {
                    return "cigarette's pack must have a positive cost";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _packPrice = double.parse(newValue!);
                },
                decoration: InputDecoration(
                  hintText: "How much does a pack cost",
                  labelText: "Packs cost",
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return "This is field is mandatory";
                  }
                  if (double.parse(value) <= 0.0) {
                    return "cigarettes smoked must have a positive value";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _smokedCiagrettesPerDay = double.parse(newValue!);
                },
                decoration: InputDecoration(
                  hintText: "How many cigarettes do you smoke daily",
                  labelText: "Cigarettes smoked",
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return "This is field is mandatory";
                  }
                  if (double.parse(value) <= 0.0) {
                    return "cigarettes in pack must have a positive value";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _cigarettesInPack = double.parse(newValue!);
                },
                decoration: InputDecoration(
                  hintText: "How many cigarettes are there in each pack",
                  labelText: "Cigarettes in pack",
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text(
                  "Let's get started",
                  style: TextStyle(
                      color: Color.fromARGB(255, 37, 71, 117),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
