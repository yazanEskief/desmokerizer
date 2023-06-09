import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class User {
  User({
    String? id,
    required this.name,
    this.localImage,
    this.netWorkImageUrl = "",
    required this.start,
    required this.cigarettesPacks,
    required this.packPrice,
    required this.smokedCiagrettesPerDay,
    required this.cigarettesInPack,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? uuid.v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;
  final String name;
  File? localImage;
  String netWorkImageUrl;
  final double cigarettesPacks;
  final double smokedCiagrettesPerDay;
  final double packPrice;
  final double cigarettesInPack;
  final DateTime start;
  final DateTime createdAt;
  final DateTime updatedAt;

  double savedMoneyPerDay() {
    final cigarettePrice = packPrice / cigarettesInPack;
    return cigarettePrice * smokedCiagrettesPerDay;
  }

  double savedMoneyPerMinute() {
    return savedMoneyPerHour() / 60;
  }

  double savedMoneyPerHour() {
    return savedMoneyPerDay() / 24;
  }

  double savedMoneyPerWeek() {
    return savedMoneyPerDay() * 7;
  }

  double savedMoneyPerMonth() {
    return savedMoneyPerDay() * 30;
  }

  double savedMoneyPerYear() {
    return savedMoneyPerDay() * 365.25;
  }
}
