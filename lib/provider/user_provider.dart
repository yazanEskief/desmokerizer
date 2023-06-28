import 'dart:convert';
import 'dart:io';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

import "package:desmokrizer/models/user.dart";

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  final db = await sql.openDatabase(
    path.join(dbPath, "desmokerizer.db"),
    onCreate: (db, version) {
      db.execute('''CREATE TABLE user(
        id TEXT PRIMARY KEY,
        name TEXT, 
        image TEXT,
        cigarettesPacks REAL,
        packPrice REAL,
        smokedCigarettesPerDay REAL,
        cigarettesInPack REAL,
        start TEXT,  
        createdAt TEXT, 
        updatedAt TEXT
      );''');

      db.execute('''CREATE TABLE moments(
        id TEXT PRIMARY KEY, 
        description TEXT, 
        createdAt TEXT, 
        imageURL TEXT, 
        updatedAt TEXT
      );''');

      return db.execute('''CREATE TABLE wishlist_items(
            id TEXT PRIMARY KEY, 
            name TEXT, 
            createdAt TEXT, 
            price REAL, 
            updatedAt TEXT
          );''');
    },
    version: 1,
  );

  return db;
}

class UserProvider extends StateNotifier<List<User>> {
  UserProvider() : super([]);

  Future<void> loadUser() async {
    final db = await _getDatabase();

    final result = await db.query("user");
    if (result.isEmpty) {
      state = [];
      return;
    }

    final userMap = result.first;

    final user = User(
      id: userMap["id"] as String,
      name: userMap["name"] as String,
      localImage: File(userMap["image"] as String),
      start: DateTime.parse(userMap["start"] as String),
      cigarettesPacks: userMap["cigarettesPacks"] as double,
      packPrice: userMap["packPrice"] as double,
      smokedCigarettesPerDay: userMap["smokedCigarettesPerDay"] as double,
      cigarettesInPack: userMap["cigarettesInPack"] as double,
      createdAt: DateTime.parse(userMap["createdAt"] as String),
      updatedAt: DateTime.parse(userMap["updatedAt"] as String),
    );

    state = [user];
  }

  void setUser(User user, File? image) async {
    state = [user];

    final db = await _getDatabase();

    db.insert("user", {
      "id": user.id,
      "name": user.name,
      "start": user.start.toIso8601String(),
      "image": user.localImage == null ? "" : user.localImage!.path,
      "cigarettesPacks": user.cigarettesPacks,
      "packPrice": user.packPrice,
      "smokedCigarettesPerDay": user.smokedCigarettesPerDay,
      "cigarettesInPack": user.cigarettesInPack,
      "createdAt": user.createdAt.toIso8601String(),
      "updatedAt": user.updatedAt.toIso8601String(),
    });

    String? userImageOnFirebase;

    if (user.localImage != null) {
      final fireStor = FirebaseStorage.instance
          .ref()
          .child("user-profile-images")
          .child("${user.id}.png");

      await fireStor.putFile(user.localImage!);
      userImageOnFirebase = await fireStor.getDownloadURL();
    }

    FirebaseDatabase.instance.ref().child("users").child(user.id).set({
      "name": user.name,
      "imageUrl": userImageOnFirebase ?? "",
      "start": user.start.toIso8601String(),
      "cigarettesPacks": user.cigarettesPacks,
      "packPrice": user.packPrice,
      "smokedCigarettesPerDay": user.smokedCigarettesPerDay,
      "cigarettesInPack": user.cigarettesInPack,
      "createdAt": user.createdAt.toIso8601String(),
      "updatedAt": user.updatedAt.toIso8601String(),
    });
  }

  Future<List<User>> loadUsersFromFirebase() async {
    final usersFromFB = await FirebaseDatabase.instance
        .ref()
        .child("users")
        .orderByChild("start")
        .limitToFirst(100)
        .get();

    final data = json.encode(usersFromFB.value);
    final temp = json.decode(data) as Map<String, dynamic>;
    List<User> result = [];

    temp.forEach((key, value) {
      final name = value["name"] as String;
      final imageUrl = value["imageUrl"] as String;
      final start = DateTime.parse(value["start"]);
      final cigarettesPacks = value["cigarettesPacks"].toDouble();
      final packPrice = value["packPrice"].toDouble();
      final smokedCigarettesPerDay = value["smokedCigarettesPerDay"].toDouble();
      final cigarettesInPack = value["cigarettesInPack"].toDouble();
      final createdAt = DateTime.parse(value["createdAt"]);
      final updatedAt = DateTime.parse(value["updatedAt"]);
      final user = User(
        id: key,
        name: name,
        netWorkImageUrl: imageUrl,
        start: start,
        cigarettesPacks: cigarettesPacks,
        packPrice: packPrice,
        smokedCigarettesPerDay: smokedCigarettesPerDay,
        cigarettesInPack: cigarettesInPack,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
      result.add(user);
    });

    result.sort((a, b) => a.start.compareTo(b.start));

    return result;
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, List<User>>((ref) => UserProvider());
