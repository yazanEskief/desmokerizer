import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/widgets/galeryScreenWidgets/image_details.dart';
import 'package:desmokrizer/models/desmokerizer_image.dart';
import 'package:desmokrizer/provider/images_provider.dart';

class GaleryScreen extends ConsumerStatefulWidget {
  const GaleryScreen({super.key});

  @override
  ConsumerState<GaleryScreen> createState() => _GaleryScreenState();
}

class _GaleryScreenState extends ConsumerState<GaleryScreen> {
  void _addImageFromCamera() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (takenImage == null) {
      return;
    }

    final image = DesmokerizerImage(imagePath: File(takenImage.path));
    ref.read(imageProvider.notifier).addImage(image);
  }

  void _addImageFromGalery() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (takenImage == null) {
      return;
    }

    final image = DesmokerizerImage(imagePath: File(takenImage.path));
    ref.read(imageProvider.notifier).addImage(image);
  }

  Widget _emptyScreenContent() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: const Text("Add moments to your galery"),
      ),
    );
  }

  void _openImageDetail(DesmokerizerImage image) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ImageDetails(image: image),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(imageProvider);

    Widget fewImagesLayout() {
      return Expanded(
        child: ListView.builder(
          itemCount: images.length,
          itemBuilder: (ctx, index) => GestureDetector(
            onTap: () => _openImageDetail(images[index]),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(1, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  images[index].imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Moments",
              style: GoogleFonts.dancingScript(
                color: const Color.fromARGB(205, 21, 25, 33),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                  size: 32,
                ),
                onChanged: (value) {},
                items: [
                  DropdownMenuItem<String>(
                    value: "Camera",
                    onTap: _addImageFromCamera,
                    child: Row(
                      children: const [
                        Icon(Icons.camera_alt_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Camera"),
                      ],
                    ),
                  ),
                  DropdownMenuItem<String>(
                    value: "Galery",
                    onTap: _addImageFromGalery,
                    child: Row(
                      children: const [
                        Icon(Icons.photo_library_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Galery"),
                      ],
                    ),
                  ),
                ],
                dropdownStyleData: DropdownStyleData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  width: 150,
                  offset: const Offset(-90, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 251, 238),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 35,
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 1,
          width: 150,
          decoration:
              const BoxDecoration(color: Color.fromARGB(160, 130, 132, 136)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 1,
          width: 120,
          decoration:
              const BoxDecoration(color: Color.fromARGB(160, 130, 132, 136)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 1,
          width: 90,
          decoration:
              const BoxDecoration(color: Color.fromARGB(160, 130, 132, 136)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 1,
          width: 60,
          decoration:
              const BoxDecoration(color: Color.fromARGB(160, 130, 132, 136)),
        ),
        const SizedBox(
          height: 50,
        ),
        if (images.isEmpty)
          _emptyScreenContent()
        else if (images.length < 9)
          fewImagesLayout()
        else
          Expanded(
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    _openImageDetail(images[index]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 0.1,
                      color: const Color.fromARGB(160, 130, 132, 136),
                    )),
                    child: Image.file(
                      images[index].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
