import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/models/wish_list_item.dart';

class WishListItemsProvider extends StateNotifier<List<WishListItem>> {
  WishListItemsProvider() : super([]);

  void addItemToList(WishListItem item) {
    if (state.isEmpty) {
      state = [item];
    } else {
      final temp = state;
      temp.add(item);
      temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      state = [...temp];
    }
  }

  void updateItem(WishListItem item) {
    final temp = state;
    var itemToUpdate = temp.singleWhere((e) => e.id == item.id);
    itemToUpdate = item;
    state = [...temp];
  }

  void removeItem(WishListItem item) {
    final temp = state;
    temp.remove(item);
    state = [...temp];
  }

  int getItemIndex(WishListItem item) {
    return state.indexOf(item);
  }

  void insertItemAtIndex(int index, WishListItem item) {
    final temp = state;
    temp.insert(index, item);
    state = [...temp];
  }
}

final wishListItemsProvider =
    StateNotifierProvider<WishListItemsProvider, List<WishListItem>>(
        (ref) => WishListItemsProvider());
