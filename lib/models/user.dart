import 'package:uuid/uuid.dart';

final uuid = Uuid();

class User {
  User({
    required this.name,
    required this.image,
    required this.start,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final String image;
  final DateTime start;
}
