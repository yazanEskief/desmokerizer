import 'package:flutter/material.dart';

import 'package:desmokrizer/models/user.dart';
import 'package:desmokrizer/data/health_cards_data.dart';
import 'package:desmokrizer/widgets/health_card.dart';

class FirstSlide extends StatefulWidget {
  const FirstSlide({super.key, required this.user});

  final User user;

  @override
  State<FirstSlide> createState() => _FirstSlideState();
}

class _FirstSlideState extends State<FirstSlide> {
  var cardsManager = {
    CardsCategory.pulse: true,
    CardsCategory.oxygen: true,
    CardsCategory.carbon: true,
    CardsCategory.nicotine: true,
  };

  void _toggleCards(CardsCategory category) {
    setState(() {
      cardsManager.forEach((key, value) {
        if (key != category) {
          cardsManager[key] = !value;
        }
        print("key: $key, value: $value");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrainst) {
        final height = constrainst.maxHeight;
        return Stack(children: [
          Container(
            width: double.infinity,
            height: height * 0.25,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 64, 192, 87),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                )),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.user.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Feel your body breathing again",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                if (cardsManager[CardsCategory.pulse]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.pulse),
                    card: cards[CardsCategory.pulse]!,
                    category: CardsCategory.pulse,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.oxygen]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.oxygen),
                    card: cards[CardsCategory.oxygen]!,
                    category: CardsCategory.oxygen,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.carbon]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.carbon),
                    card: cards[CardsCategory.carbon]!,
                    category: CardsCategory.carbon,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.nicotine]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.nicotine),
                    card: cards[CardsCategory.nicotine]!,
                    category: CardsCategory.nicotine,
                    onToggleCard: _toggleCards,
                  ),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
