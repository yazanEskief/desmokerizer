import 'package:flutter/material.dart';

class NotSmokedTimer extends StatefulWidget {
  const NotSmokedTimer({super.key});

  @override
  State<StatefulWidget> createState() => _NotSmokedTimerState();
}

class _NotSmokedTimerState extends State<NotSmokedTimer> {
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
                children: const [
                  Text(
                    "Time not smoked",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "1d 12h 30m",
                    style: TextStyle(
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
