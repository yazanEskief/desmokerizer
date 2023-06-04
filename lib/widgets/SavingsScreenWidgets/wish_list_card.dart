import 'package:flutter/material.dart';

class WishListCard extends StatelessWidget {
  const WishListCard({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 206, 224, 241),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
