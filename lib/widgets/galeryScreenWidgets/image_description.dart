import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/models/desmokerizer_image.dart';
import 'package:desmokrizer/provider/images_provider.dart';

class ImageDescription extends ConsumerStatefulWidget {
  const ImageDescription({
    super.key,
    required this.image,
  });

  final DesmokerizerImage image;

  @override
  ConsumerState<ImageDescription> createState() => _ImageDescriptionState();
}

class _ImageDescriptionState extends ConsumerState<ImageDescription> {
  late final _textController;

  @override
  void initState() {
    _textController =
        TextEditingController(text: widget.image.description ?? "");
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveDescription() {
    final enteredText = _textController.text;

    widget.image.description = enteredText;

    ref.read(imageProvider.notifier).updateImage(widget.image);

    Navigator.of(context).pop<DesmokerizerImage>(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Close",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _saveDescription,
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Describe Your moment",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary, fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 400,
            child: TextField(
              controller: _textController,
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.primary),
                border: const OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
