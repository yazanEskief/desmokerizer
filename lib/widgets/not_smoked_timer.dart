import 'dart:async';
import 'package:flutter/material.dart';

import 'package:desmokrizer/models/user.dart';

class NotSmokedTimer extends StatefulWidget {
  const NotSmokedTimer({super.key, required this.user});

  final User user;

  @override
  State<NotSmokedTimer> createState() => _NotSmokedTimerState();
}

class _NotSmokedTimerState extends State<NotSmokedTimer> {
  late Timer _timer;
  DateTime _timeNotSmoked = DateTime.now();

  @override
  void initState() {
    _incrementTimer();
    super.initState();
  }

  void _incrementTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        _timeNotSmoked = _timeNotSmoked.add(duration);
      });
    });
  }

  String _passedTime() {
    int daysPassed = _timeNotSmoked.difference(widget.user.start).inDays;
    int year = daysPassed ~/ 365;
    int month = (daysPassed - (year * 365)) ~/ 30;
    int day = daysPassed - (year * 365) - (month * 30);
    int hours = _timeNotSmoked.difference(widget.user.start).inHours -
        (day * 24) -
        (month * 30 * 24) -
        (year * 365 * 24);
    int minutes = _timeNotSmoked.difference(widget.user.start).inMinutes -
        (hours * 60) -
        (day * 24 * 60) -
        (month * 30 * 24 * 60) -
        (year * 365 * 24 * 60);

    return "${year != 0 ? "$year" "y" : ""} ${month != 0 ? "$month" "m" : ""} ${"$day" "d"} ${year > 0 ? "" : "$hours" "h"} ${month > 0 || year > 0 ? "" : "$minutes" "m"}";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/homeScreenBG.jpg"),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                bottom: 20,
                top: 10,
              ),
              height: 100,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black12,
                    Colors.black54,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Time not smoked",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _passedTime(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
