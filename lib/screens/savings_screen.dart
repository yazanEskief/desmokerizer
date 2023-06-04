import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/widgets/SavingsScreenWidgets/money_saved_tab.dart';
import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/widgets/SavingsScreenWidgets/wish_list_tab.dart';

class SavingsScreen extends ConsumerStatefulWidget {
  const SavingsScreen({super.key});

  @override
  ConsumerState<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends ConsumerState<SavingsScreen> {
  int _currentActiveTab = 0;

  void _setActiveTab(int value) {
    setState(() {
      _currentActiveTab = value;
    });
  }

  Widget _activeTab(String tabName) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 164, 204, 157),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        tabName,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Column(
      children: [
        if (_currentActiveTab == 0)
          const MoneySavedTab()
        else
          const WishListTab(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: CupertinoTabBar(
              currentIndex: _currentActiveTab,
              onTap: _setActiveTab,
              backgroundColor: const Color.fromARGB(255, 206, 224, 241),
              items: [
                BottomNavigationBarItem(
                  icon: Text(
                    "Money saved",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                  ),
                  activeIcon: _activeTab("Money saved"),
                ),
                BottomNavigationBarItem(
                  icon: Text(
                    "Whishlist",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                  ),
                  activeIcon: _activeTab("Wishlist"),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
