import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/provider/user_provider.dart';

class WishlistTotlaSavedCard extends ConsumerStatefulWidget {
  const WishlistTotlaSavedCard({
    super.key,
    required this.title,
  });

  final String title;

  @override
  ConsumerState<WishlistTotlaSavedCard> createState() =>
      _WishlistTotlaSavedCardState();
}

class _WishlistTotlaSavedCardState
    extends ConsumerState<WishlistTotlaSavedCard> {
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
          DateTime.now().difference(ref.read(userProvider).start);
      final tempTotalSavedMoney =
          passedTime.inMinutes * ref.read(userProvider).savedMoneyPerMinute();
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
    final passedTime = DateTime.now().difference(ref.read(userProvider).start);
    _totalSavedMoney =
        passedTime.inMinutes * ref.read(userProvider).savedMoneyPerMinute();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 206, 224, 241),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            _totalSavedMoney.toStringAsFixed(2),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
