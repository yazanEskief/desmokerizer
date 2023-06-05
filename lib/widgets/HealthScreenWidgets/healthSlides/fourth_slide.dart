import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/data/health_cards_data.dart';
import 'package:desmokrizer/widgets/HealthScreenWidgets/health_card.dart';

class FourthSlide extends ConsumerStatefulWidget {
  const FourthSlide({super.key});

  @override
  ConsumerState<FourthSlide> createState() => _FourthSlideState();
}

class _FourthSlideState extends ConsumerState<FourthSlide> {
  var cardsManager = {
    CardsCategory.immunity: true,
    CardsCategory.heartDisease: true,
    CardsCategory.lungCancer: true,
    CardsCategory.heartAttack: true,
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
    final user = ref.watch(userProvider).first;

    return LayoutBuilder(
      builder: (context, constrainst) {
        final height = constrainst.maxHeight;
        return Stack(children: [
          Container(
            width: double.infinity,
            height: height * 0.86,
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
                if (cardsManager[CardsCategory.immunity]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.immunity),
                    card: cards[CardsCategory.immunity]!,
                    category: CardsCategory.immunity,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.heartDisease]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.heartDisease),
                    card: cards[CardsCategory.heartDisease]!,
                    category: CardsCategory.heartDisease,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.lungCancer]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.lungCancer),
                    card: cards[CardsCategory.lungCancer]!,
                    category: CardsCategory.lungCancer,
                    onToggleCard: _toggleCards,
                  ),
                if (cardsManager[CardsCategory.heartAttack]!)
                  HealthCard(
                    key: const ValueKey(CardsCategory.heartAttack),
                    card: cards[CardsCategory.heartAttack]!,
                    category: CardsCategory.heartAttack,
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
