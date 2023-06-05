import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/models/desmokerizer_image.dart';

class ImageProvider extends StateNotifier<List<DesmokerizerImage>> {
  ImageProvider() : super([]);

  void addImage(DesmokerizerImage image) {
    state = [...state, image];
  }

  void updateImage(DesmokerizerImage image) {
    final temp = state;
    final imageIndex = temp.indexOf(image);
    temp[imageIndex] = image;
    state = [...temp];
  }

  void deleteImage(DesmokerizerImage image) {
    final temp = state;
    temp.remove(image);
    state = [...state];
  }
}

final imageProvider =
    StateNotifierProvider<ImageProvider, List<DesmokerizerImage>>(
        (ref) => ImageProvider());
