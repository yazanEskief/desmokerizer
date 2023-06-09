import 'package:flutter/material.dart';

import 'package:desmokrizer/models/user.dart';

class LeaderBoardItem extends StatelessWidget {
  const LeaderBoardItem({super.key, required this.user, required this.index});

  final User user;
  final int index;

  String daysNotSmoked() {
    return DateTime.now().difference(user.start).inDays.toString();
  }

  Widget _setBadge() {
    if (index == 0) {
      return Image.asset(
        "assets/images/cup.png",
        width: 24,
        height: 24,
        color: Colors.amber[600],
      );
    }

    if (index == 1) {
      return Image.asset(
        "assets/images/cup.png",
        width: 24,
        height: 24,
        color: Colors.grey[600],
      );
    }

    if (index == 2) {
      return Image.asset(
        "assets/images/cup.png",
        width: 24,
        height: 24,
        color: Colors.brown[600],
      );
    }

    return CircleAvatar(
      radius: 12,
      backgroundColor: Colors.grey[400],
      child: Text(
        "${index + 1}",
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 73, 80, 87),
        ),
      ),
    );
  }

  ImageProvider _getBackgroundImage(User user) {
    if (user.netWorkImageUrl.isEmpty) {
      return const AssetImage("assets/images/user.png");
    }
    return NetworkImage(user.netWorkImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 235, 251, 238),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 16),
        leading: Container(
            padding: const EdgeInsets.only(left: 20), child: _setBadge()),
        title: SizedBox(
          width: 200,
          child: Container(
            decoration: const BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: _getBackgroundImage(user),
                ),
                const SizedBox(
                  width: 24,
                ),
                Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        trailing: SizedBox(
          width: 40,
          child: Text(
            daysNotSmoked(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
