import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/models/card_health.dart';
import 'package:desmokrizer/data/health_cards_data.dart';

class HealthCard extends ConsumerStatefulWidget {
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
  ConsumerState<HealthCard> createState() => _HealthCardState();
}

class _HealthCardState extends ConsumerState<HealthCard> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  bool _isOpen = false;
  late ValueNotifier<double> valueNotifier;

  @override
  void initState() {
    valueNotifier = ValueNotifier(_calcPassedTime());
    _incrementTimer();
    super.initState();
  }

  void _incrementTimer() {
    const duration = Duration(minutes: 1);
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        _currentTime = _currentTime.add(duration);
      });
    });
  }

  double _calcPassedTime() {
    final userNotSmokedTime = ref.read(userProvider).first.start;
    final passedTime = _currentTime.difference(userNotSmokedTime);
    final percentage =
        ((passedTime.inMinutes / widget.card.durationToRecover.inMinutes) *
            100);

    final result = percentage > 100 ? 100.0 : percentage;
    return result;
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    _timer.cancel();
    super.dispose();
  }

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
      height: _isOpen ? 535 : null,
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
                          width: 10,
                        ),
                        SizedBox(
                          width: 55,
                          height: 55,
                          child: SimpleCircularProgressBar(
                            animationDuration: 1,
                            backStrokeWidth: 7,
                            backColor: const Color.fromARGB(255, 186, 231, 182),
                            maxValue: 100,
                            progressColors: const [
                              Color.fromARGB(255, 85, 165, 94),
                            ],
                            valueNotifier: valueNotifier,
                            progressStrokeWidth: 7,
                            onGetText: (p0) {
                              return Text(
                                p0.toStringAsFixed(0),
                              );
                            },
                          ),
                        ),
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
