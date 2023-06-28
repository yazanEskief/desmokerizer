import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;

import 'package:desmokrizer/models/desmokerizer_image.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, "desmokerizer.db"),
    version: 1,
  );

  return db;
}

class ImageProvider extends StateNotifier<List<DesmokerizerImage>> {
  ImageProvider() : super([]);

  Future<void> loadImages() async {
    final db = await _getDatabase();
    final moments = await db.query("moments", orderBy: "createdAt DESC");

    if (moments.isEmpty) {
      state = [];
      return;
    }

    state = moments
        .map(
          (e) => DesmokerizerImage(
            id: e["id"] as String,
            imagePath: File(e["imageURL"] as String),
            description:
                e["description"] != null ? e["description"] as String : "",
            createdAt: DateTime.parse(e["createdAt"] as String),
            updatedAt: DateTime.parse(e["updatedAt"] as String),
          ),
        )
        .toList();
  }

  void addImage(DesmokerizerImage image) async {
    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.imagePath.path);
    final copiedImage = await image.imagePath.copy("${appDir.path}/$filename");

    image.imagePath = copiedImage;

    state = [...state, image];

    final db = await _getDatabase();
    db.insert("moments", {
      "id": image.id,
      "description": image.description,
      "imageURL": image.imagePath.path,
      "createdAt": image.createdAt.toIso8601String(),
      "updatedAt": image.updatedAt.toIso8601String(),
    });
  }

  void updateImage(DesmokerizerImage image) async {
    final temp = state;
    final imageIndex = temp.indexOf(image);
    image.updatedAt = DateTime.now();
    temp[imageIndex] = image;
    state = [...temp];

    final db = await _getDatabase();
    db.update(
      "moments",
      {
        "updatedAt": image.updatedAt.toIso8601String(),
        "description": image.description,
        "imageURL": image.imagePath.path,
      },
      where: "id = ?",
      whereArgs: [image.id],
    );
  }

  void deleteImage(DesmokerizerImage image) async {
    final temp = state;
    temp.remove(image);
    state = [...state];

    final db = await _getDatabase();
    db.delete(
      "moments",
      where: "id = ?",
      whereArgs: [image.id],
    );
  }
}

final imageProvider =
    StateNotifierProvider<ImageProvider, List<DesmokerizerImage>>(
        (ref) => ImageProvider());
