import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

import 'package:desmokrizer/models/wish_list_item.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, "desmokerizer.db"),
    version: 1,
  );

  return db;
}

class WishListItemsProvider extends StateNotifier<List<WishListItem>> {
  WishListItemsProvider() : super([]);

  Future<void> loadWishlistItems() async {
    final db = await _getDatabase();
    final wishlistItems =
        await db.query("wishlist_items", orderBy: "createdAt ASC");

    if (wishlistItems.isEmpty) {
      state = [];
      return;
    }

    state = wishlistItems
        .map(
          (e) => WishListItem(
            id: e["id"] as String,
            name: e["name"] as String,
            price: e["price"] as double,
            createdAt: DateTime.parse(e["createdAt"] as String),
          ),
        )
        .toList();
  }

  void addItemToList(WishListItem item) async {
    if (state.isEmpty) {
      state = [item];
    } else {
      final temp = state;
      temp.add(item);
      temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      state = [...temp];
    }

    final db = await _getDatabase();

    db.insert("wishlist_items", {
      "id": item.id,
      "name": item.name,
      "price": item.price,
      "createdAt": item.createdAt.toIso8601String()
    });
  }

  void updateItem(WishListItem item) async {
    final temp = state;
    var itemToUpdate = temp.singleWhere((e) => e.id == item.id);
    itemToUpdate = item;
    itemToUpdate.updatedAt = DateTime.now();
    state = [...temp];

    final db = await _getDatabase();
    db.update(
      "wishlist_items",
      {
        "name": item.name,
        "price": item.price,
        "updatedAt": itemToUpdate.updatedAt!.toIso8601String(),
      },
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  void removeItem(WishListItem item) async {
    final temp = state;
    temp.remove(item);
    state = [...temp];

    final db = await _getDatabase();
    db.delete(
      "wishlist_items",
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  int getItemIndex(WishListItem item) {
    return state.indexOf(item);
  }

  void insertItemAtIndex(int index, WishListItem item) async {
    final temp = state;
    temp.insert(index, item);
    state = [...temp];

    final db = await _getDatabase();
    db.insert("wishlist_items", {
      "id": item.id,
      "name": item.name,
      "price": item.price,
      "createdAt": item.createdAt.toIso8601String()
    });
  }
}

final wishListItemsProvider =
    StateNotifierProvider<WishListItemsProvider, List<WishListItem>>(
        (ref) => WishListItemsProvider());
