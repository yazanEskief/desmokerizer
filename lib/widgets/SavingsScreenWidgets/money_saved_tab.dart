import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/widgets/SavingsScreenWidgets/total_saved_card.dart';
import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/widgets/SavingsScreenWidgets/savings_card.dart';

class MoneySavedTab extends ConsumerStatefulWidget {
  const MoneySavedTab({
    super.key,
  });

  @override
  ConsumerState<MoneySavedTab> createState() => _MoneySavedTabState();
}

class _MoneySavedTabState extends ConsumerState<MoneySavedTab> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).first;

    return Expanded(
      child: Column(
        children: [
          Image.asset(
            "assets/images/savings.png",
          ),
          const TotalSavedCard(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SavingsCard(
                  title: "Per day",
                  amount: user.savedMoneyPerDay(),
                ),
                SavingsCard(
                  title: "Per week",
                  amount: user.savedMoneyPerWeek(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SavingsCard(
                  title: "Per month",
                  amount: user.savedMoneyPerMonth(),
                ),
                SavingsCard(
                  title: "Per year",
                  amount: user.savedMoneyPerYear(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
