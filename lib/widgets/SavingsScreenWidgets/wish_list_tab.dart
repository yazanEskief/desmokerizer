import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:desmokrizer/widgets/SavingsScreenWidgets/wishlist_total_saved_card.dart';
import 'package:desmokrizer/models/wish_list_item.dart';
import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/widgets/SavingsScreenWidgets/new_wishlist_item.dart';
import 'package:desmokrizer/provider/wishlist_items_provider.dart';
import 'package:desmokrizer/widgets/SavingsScreenWidgets/wishlist_item_card.dart';
import 'package:desmokrizer/widgets/SavingsScreenWidgets/wish_list_card.dart';

class WishListTab extends ConsumerStatefulWidget {
  const WishListTab({
    super.key,
  });

  @override
  ConsumerState<WishListTab> createState() => _WishListTabState();
}

class _WishListTabState extends ConsumerState<WishListTab> {
  void _removeItem(WishListItem item) {
    int index = ref.read(wishListItemsProvider.notifier).getItemIndex(item);

    ref.read(wishListItemsProvider.notifier).removeItem(item);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${item.name} was removed form your Wishlist",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
        ),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            ref
                .read(wishListItemsProvider.notifier)
                .insertItemAtIndex(index, item);
          },
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showBottomModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewWishlistItem(),
    );
  }

  String _calcAchievedItems() {
    final totalSaved =
        DateTime.now().difference(ref.read(userProvider).start).inMinutes *
            ref.read(userProvider).savedMoneyPerMinute();
    final totalItems = ref.read(wishListItemsProvider).length;

    int completed = 0;
    double accum = 0;
    for (var element in ref.read(wishListItemsProvider)) {
      accum += element.price;
      if (totalSaved >= accum) {
        completed++;
      } else {
        break;
      }
    }

    return "$completed / $totalItems";
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = ref.watch(wishListItemsProvider);
    final user = ref.watch(userProvider);

    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WishListCard(
                  title: "Saved by day",
                  content: "${user.savedMoneyPerDay().toStringAsFixed(0)} €",
                ),
                WishListCard(
                  title: "Achieved",
                  content: _calcAchievedItems(),
                ),
                const WishlistTotlaSavedCard(title: "Total saved"),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 1,
                  color: Colors.black,
                ),
                Text(
                  "My Wishlist",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  width: 120,
                  height: 1,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ListView.builder(
                    itemCount: wishlist.length,
                    itemBuilder: (ctx, index) => Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Slidable(
                        key: ValueKey(wishlist[index].id),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                _removeItem(wishlist[index]);
                              },
                              label: "Remove",
                              backgroundColor:
                                  const Color.fromARGB(255, 240, 62, 62),
                              icon: Icons.delete,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (ctx) => NewWishlistItem(
                                    isEditing: true,
                                    wishlistItem: wishlist[index],
                                  ),
                                );
                              },
                              label: "Edit",
                              backgroundColor:
                                  const Color.fromARGB(255, 85, 165, 94),
                              icon: Icons.edit_square,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        child: WishlistItemCard(
                          key: ValueKey([wishlist[index].id]),
                          wishlistItem: wishlist[index],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 50,
                  child: FloatingActionButton(
                    onPressed: _showBottomModal,
                    backgroundColor: const Color.fromARGB(255, 85, 165, 94),
                    elevation: 5,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
