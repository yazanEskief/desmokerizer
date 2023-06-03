import 'package:uuid/uuid.dart';

const uuid = Uuid();

class WishListItem {
  WishListItem({required this.name, required this.price, this.updatedAt})
      : id = uuid.v4(),
        isCompleted = false,
        createdAt = DateTime.now();

  final String id;
  String name;
  double price;
  bool isCompleted;
  final DateTime createdAt;
  DateTime? updatedAt;
}
