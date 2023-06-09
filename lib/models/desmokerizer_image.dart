import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = Uuid();

class DesmokerizerImage {
  DesmokerizerImage({
    required this.imagePath,
    this.description,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? uuid.v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;
  File imagePath;
  String? description;
  final DateTime createdAt;
  DateTime updatedAt;

  String get formatedDate {
    final formatter = DateFormat('yyyy-MM-dd - HH:mm');
    return formatter.format(createdAt.toLocal());
  }
}
