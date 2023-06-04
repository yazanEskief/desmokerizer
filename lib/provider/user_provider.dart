import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:desmokrizer/models/user.dart";

class UserProvider extends StateNotifier<User> {
  UserProvider()
      : super(
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
        );

  void setUser(User user) {
    state = User(
      image: user.image,
      name: user.name,
      start: user.start,
      cigarettesInPack: user.cigarettesInPack,
      cigarettesPacks: user.cigarettesPacks,
      packPrice: user.packPrice,
      smokedCiagrettesPerDay: user.smokedCiagrettesPerDay,
    );
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User>((ref) => UserProvider());
