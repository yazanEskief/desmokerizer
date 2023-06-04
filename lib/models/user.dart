import 'package:uuid/uuid.dart';

final uuid = Uuid();

class User {
  User({
    required this.name,
    required this.image,
    required this.start,
    required this.cigarettesPacks,
    required this.packPrice,
    required this.smokedCiagrettesPerDay,
    required this.cigarettesInPack,
  })  : id = uuid.v4(),
        createdAt = DateTime.now();

  final String id;
  final String name;
  final String image;
  final double cigarettesPacks;
  final double smokedCiagrettesPerDay;
  final double packPrice;
  final double cigarettesInPack;
  final DateTime start;
  final DateTime createdAt;
  DateTime? updatedAt;

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
