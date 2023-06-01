import 'package:flutter/material.dart';

import 'package:desmokrizer/models/card_health.dart';
import 'package:desmokrizer/data/health_cards_data.dart';

class HealthCard extends StatefulWidget {
  const HealthCard({
    super.key,
    required this.onToggleCard,
    required this.card,
    required this.category,
  });

  final void Function(CardsCategory) onToggleCard;
  final CardHealth card;
  final CardsCategory category;

  @override
  State<HealthCard> createState() => _HealthCardState();
}

class _HealthCardState extends State<HealthCard> {
  bool _isOpen = false;

  Widget _cardOpenWidget() {
    return Container(
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.card.cardName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.card.shortDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14, color: const Color.fromARGB(255, 130, 132, 136)),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            widget.card.image,
            width: 150,
            height: 150,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.card.lonbgDescription,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                _isOpen = !_isOpen;
              });
              widget.onToggleCard(widget.category);
            },
            icon: const Icon(Icons.keyboard_arrow_up),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _isOpen ? 550 : null,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 5,
        ),
        child: _isOpen
            ? _cardOpenWidget()
            : Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 50,
                        ),
                        const Text("100%"),
                        const SizedBox(
                          width: 30,
                        ),
                        // const Spacer(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.card.cardName,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.card.shortDescription,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 10,
                                        color: const Color.fromARGB(
                                            255, 130, 132, 136)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isOpen = !_isOpen;
                        });
                        widget.onToggleCard(widget.category);
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
