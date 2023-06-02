import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/data/health_cards_data.dart';
import 'package:desmokrizer/widgets/health_card.dart';

class ThirdSlide extends ConsumerStatefulWidget {
  const ThirdSlide({super.key});

  @override
  ConsumerState<ThirdSlide> createState() => _ThirdSlideState();
}

class _ThirdSlideState extends ConsumerState<ThirdSlide> {
  var cardsManager = {
    CardsCategory.toothStaining: true,
    CardsCategory.gumAndTeeth: true,
    CardsCategory.circulation: true,
    CardsCategory.gumTexture: true,
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
            height: height * 0.69,
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
                if (cardsManager[CardsCategory.toothStaining]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.toothStaining),
                    card: cards[CardsCategory.toothStaining]!,
                    category: CardsCategory.toothStaining,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.gumAndTeeth]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.gumAndTeeth),
                    card: cards[CardsCategory.gumAndTeeth]!,
                    category: CardsCategory.gumAndTeeth,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.circulation]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.circulation),
                    card: cards[CardsCategory.circulation]!,
                    category: CardsCategory.circulation,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.gumTexture]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.gumTexture),
                    card: cards[CardsCategory.gumTexture]!,
                    category: CardsCategory.gumTexture,
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
