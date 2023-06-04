import 'package:flutter/material.dart';

class SavingsCard extends StatelessWidget {
  const SavingsCard({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 110,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 206, 224, 241),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${amount.toStringAsFixed(0)} €",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 28,
                ),
          ),
        ],
      ),
    );
  }
}
