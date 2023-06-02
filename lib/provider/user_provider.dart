import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:desmokrizer/models/user.dart";

class UserProvider extends StateNotifier<User> {
  UserProvider()
      : super(
          User(
            name: "Yazan",
            image: "assets/images/Paul.jpg",
            start: DateTime.now().subtract(
              const Duration(hours: 2),
            ),
          ),
        );

  void setUser(User user) {
    state = User(
      image: user.image,
      name: user.name,
      start: user.start,
    );
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, User>((ref) => UserProvider());
