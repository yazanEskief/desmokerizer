import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:desmokrizer/widgets/leader_board_item.dart';
import 'package:desmokrizer/widgets/not_smoked_timer.dart';
import 'package:desmokrizer/data/dummyUser.dart';
import 'package:desmokrizer/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = User(
    name: "Yazan",
    start: DateTime.now().subtract(const Duration(days: 30)),
    image: "assets/images/Paul.jpg",
  );

  @override
  Widget build(BuildContext context) {
    final sortedUser = users;
    sortedUser.sort((a, b) => a.start.compareTo(b.start));

    return Column(
      children: [
        NotSmokedTimer(user: user),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Wall of Fame",
          style: GoogleFonts.dancingScript(
            color: const Color.fromARGB(255, 43, 138, 62),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Days",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 10,
                  ),
            ),
            const SizedBox(
              width: 40,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            // padding: const EdgeInsets.only(bottom: 20),
            itemCount: sortedUser.length,
            shrinkWrap: true,
            itemBuilder: (ctx, index) => LeaderBoardItem(
              index: index,
              user: sortedUser[index],
            ),
          ),
        )
      ],
    );
  }
}
