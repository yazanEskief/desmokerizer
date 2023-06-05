import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:sqflite/sqflite.dart';

import "package:desmokrizer/models/user.dart";

class UserProvider extends StateNotifier<List<User>> {
  UserProvider()
      : super([
          User(
            name: "Yazan",
            image: "assets/images/Paul.jpg",
            cigarettesPacks: 2,
            packPrice: 8,
            smokedCiagrettesPerDay: 23,
            cigarettesInPack: 20,
            start: DateTime.now().subtract(
              const Duration(days: 30),
            ),
          ),
        ]);

  void setUser(User user) {
    state = [user];
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, List<User>>((ref) => UserProvider());
