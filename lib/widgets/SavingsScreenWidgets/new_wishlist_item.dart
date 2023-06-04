import 'package:desmokrizer/provider/wishlist_items_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/models/wish_list_item.dart';

class NewWishlistItem extends ConsumerStatefulWidget {
  NewWishlistItem({
    super.key,
    this.wishlistItem,
    this.isEditing = false,
  });

  WishListItem? wishlistItem;
  final bool isEditing;

  @override
  ConsumerState<NewWishlistItem> createState() => _NewWishlistItemState();
}

class _NewWishlistItemState extends ConsumerState<NewWishlistItem> {
  final formKey = GlobalKey<FormState>();
  String _itemName = "";
  double _itemPrice = 0;

  String? _validateItemName(String? name) {
    if (name == null || name.isEmpty) {
      return "An item must have a name!";
    }

    return null;
  }

  String? _validatePrice(String? price) {
    if (price == null || price.isEmpty) {
      return "An item must have a price!";
    }

    if (double.parse(price) <= 0) {
      return "An item can't have a negative price!";
    }

    return null;
  }

  void _sumbit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (!widget.isEditing) {
        final newItem = WishListItem(name: _itemName, price: _itemPrice);

        ref.read(wishListItemsProvider.notifier).addItemToList(newItem);
      } else {
        widget.wishlistItem!.name = _itemName;
        widget.wishlistItem!.price = _itemPrice;
        widget.wishlistItem!.updatedAt = DateTime.now();

        ref
            .read(wishListItemsProvider.notifier)
            .updateItem(widget.wishlistItem!);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 64, 192, 87),
                      ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _sumbit,
                child: Text(
                  "Save",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 64, 192, 87),
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Add an item to your Wishlist",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18,
                        // color: const Color.fromARGB(255, 206, 224, 241),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue:
                      widget.isEditing ? widget.wishlistItem!.name : null,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color.fromARGB(255, 130, 132, 136),
                            ),
                  ),
                  autocorrect: true,
                  enableSuggestions: true,
                  textCapitalization: TextCapitalization.none,
                  maxLength: 20,
                  validator: _validateItemName,
                  onSaved: (newValue) {
                    _itemName = newValue!;
                  },
                ),
                TextFormField(
                  initialValue: widget.isEditing
                      ? widget.wishlistItem!.price.toStringAsFixed(2)
                      : null,
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color.fromARGB(255, 130, 132, 136),
                            ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  validator: _validatePrice,
                  onSaved: (newValue) {
                    _itemPrice = double.parse(newValue!);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: _sumbit,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 64, 192, 87)),
                  ),
                  child: Text(
                    widget.isEditing ? "Update item" : "Create item",
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
