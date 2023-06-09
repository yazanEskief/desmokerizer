import 'package:desmokrizer/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/widgets/homeScreenWidgets/leader_board_item.dart';
import 'package:desmokrizer/widgets/homeScreenWidgets/not_smoked_timer.dart';
import 'package:desmokrizer/data/dummyUser.dart';
import 'package:desmokrizer/models/user.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List<User>> usersFromFB;

  @override
  void initState() {
    usersFromFB = ref.read(userProvider.notifier).loadUsersFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final sortedUser = users;
    sortedUser.sort((a, b) => a.start.compareTo(b.start));

    return Column(
      children: [
        NotSmokedTimer(user: user.first),
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
        FutureBuilder(
          future: usersFromFB,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) => LeaderBoardItem(
                    index: index,
                    user: snapshot.data![index],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("There no users to display"),
              );
            }
          },
        )
      ],
    );
  }
}
