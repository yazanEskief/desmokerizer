import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/provider/user_provider.dart';

class TotalSavedCard extends ConsumerStatefulWidget {
  const TotalSavedCard({super.key});

  @override
  ConsumerState<TotalSavedCard> createState() => _TotalSavedCardState();
}

class _TotalSavedCardState extends ConsumerState<TotalSavedCard> {
  late Timer _timer;
  late double _totalSavedMoney;

  @override
  void initState() {
    _calcTotalSavedMoney();
    _incrementTimer();
    super.initState();
  }

  void _incrementTimer() {
    const duration = Duration(minutes: 1);
    _timer = Timer.periodic(duration, (timer) {
      final passedTime =
          DateTime.now().difference(ref.read(userProvider).first.start);
      final tempTotalSavedMoney = passedTime.inMinutes *
          ref.read(userProvider).first.savedMoneyPerMinute();
      if (tempTotalSavedMoney.toStringAsFixed(2) !=
          _totalSavedMoney.toStringAsFixed(2)) {
        setState(() {
          _totalSavedMoney = tempTotalSavedMoney;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calcTotalSavedMoney() {
    final passedTime =
        DateTime.now().difference(ref.read(userProvider).first.start);
    _totalSavedMoney = passedTime.inMinutes *
        ref.read(userProvider).first.savedMoneyPerMinute();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(160, 215, 177, 73),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Text(
            "Money saved",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 22,
                ),
          ),
          const Spacer(),
          Text(
            "${_totalSavedMoney.toStringAsFixed(2)} €",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 22,
                ),
          ),
        ],
      ),
    );
  }
}
