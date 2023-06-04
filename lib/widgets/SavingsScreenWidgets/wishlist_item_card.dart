import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/widgets/SavingsScreenWidgets/wishlist_item_card_remaining_text.dart';
import 'package:desmokrizer/widgets/SavingsScreenWidgets/wishlist_item_card_progress_circle.dart';
import 'package:desmokrizer/models/wish_list_item.dart';

class WishlistItemCard extends ConsumerStatefulWidget {
  const WishlistItemCard({
    super.key,
    required this.wishlistItem,
  });

  final WishListItem wishlistItem;

  @override
  ConsumerState<WishlistItemCard> createState() => _WishlistItemCardState();
}

class _WishlistItemCardState extends ConsumerState<WishlistItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: [
            SizedBox(
                width: 55,
                height: 55,
                child: WishlistItemCardProgressCircle(
                  wishlistItem: widget.wishlistItem,
                )),
            const SizedBox(
              width: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.wishlistItem.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                WishlistItemCardRemainingText(wishlistItem: widget.wishlistItem)
              ],
            ),
            const Spacer(),
            Text(
              "${widget.wishlistItem.price.toStringAsFixed(0)} €",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
