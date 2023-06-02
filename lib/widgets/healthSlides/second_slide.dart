import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/data/health_cards_data.dart';
import 'package:desmokrizer/widgets/health_card.dart';

class SecondSlide extends ConsumerStatefulWidget {
  const SecondSlide({super.key});

  @override
  ConsumerState<SecondSlide> createState() => _SecondSlideState();
}

class _SecondSlideState extends ConsumerState<SecondSlide> {
  var cardsManager = {
    CardsCategory.tasteAndSmell: true,
    CardsCategory.breathing: true,
    CardsCategory.energy: true,
    CardsCategory.badBreath: true,
  };

  void _toggleCards(CardsCategory category) {
    setState(() {
      cardsManager.forEach((key, value) {
        if (key != category) {
          cardsManager[key] = !value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return LayoutBuilder(
      builder: (context, constrainst) {
        final height = constrainst.maxHeight;
        return Stack(children: [
          Container(
            width: double.infinity,
            height: height * 0.45,
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
                  user.name,
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
                if (cardsManager[CardsCategory.tasteAndSmell]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.tasteAndSmell),
                    card: cards[CardsCategory.tasteAndSmell]!,
                    category: CardsCategory.tasteAndSmell,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.breathing]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.breathing),
                    card: cards[CardsCategory.breathing]!,
                    category: CardsCategory.breathing,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.energy]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.energy),
                    card: cards[CardsCategory.energy]!,
                    category: CardsCategory.energy,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.badBreath]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.badBreath),
                    card: cards[CardsCategory.badBreath]!,
                    category: CardsCategory.badBreath,
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
