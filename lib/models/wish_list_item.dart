import 'package:uuid/uuid.dart';

const uuid = Uuid();

class WishListItem {
  WishListItem({
    required this.name,
    required this.price,
    DateTime? createdAt,
    String? id,
    this.updatedAt,
  })  : id = id ?? uuid.v4(),
        createdAt = createdAt ?? DateTime.now();

  final String id;
  String name;
  double price;
  final DateTime createdAt;
  DateTime? updatedAt;
}
