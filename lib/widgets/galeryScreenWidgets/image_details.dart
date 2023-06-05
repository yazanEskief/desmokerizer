import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/models/desmokerizer_image.dart';
import 'package:desmokrizer/widgets/galeryScreenWidgets/image_description.dart';
import 'package:desmokrizer/provider/images_provider.dart';

class ImageDetails extends ConsumerStatefulWidget {
  const ImageDetails({
    super.key,
    required this.image,
  });

  final DesmokerizerImage image;

  @override
  ConsumerState<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends ConsumerState<ImageDetails> {
  void _createDescription() async {
    final imageWithDescription = await showModalBottomSheet<DesmokerizerImage>(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      backgroundColor: const Color.fromARGB(255, 235, 251, 238),
      builder: (ctx) => ImageDescription(image: widget.image),
    );

    if (imageWithDescription == null) {
      return;
    }

    setState(() {
      widget.image.description = imageWithDescription.description;
    });
  }

  void _deleteImage() {
    ref.read(imageProvider.notifier).deleteImage(widget.image);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Moment",
          style: GoogleFonts.dancingScript(
            color: const Color.fromARGB(255, 235, 251, 238),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _createDescription,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: _deleteImage,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 64, 192, 87),
              Color.fromARGB(255, 235, 251, 238),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(widget.image.imagePath)),
                    borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Text(
                      "Moment from",
                      style: GoogleFonts.dancingScript(
                        color: const Color.fromARGB(255, 123, 97, 255),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.image.formatedDate,
                      style: GoogleFonts.dancingScript(
                        color: const Color.fromARGB(255, 123, 97, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "About",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.dancingScript(
                        color: const Color.fromARGB(255, 37, 71, 117),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 160),
                    height: 3,
                    width: 70,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              if (widget.image.description == null)
                GestureDetector(
                  onTap: _createDescription,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 37, 71, 117)),
                    ),
                    child: const Text(
                      "Describe your moment",
                      style: TextStyle(color: Color.fromARGB(255, 37, 71, 117)),
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.image.description!,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 37, 71, 117)),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
