import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'package:desmokrizer/models/wish_list_item.dart';
import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/provider/wishlist_items_provider.dart';

class WishlistItemCardProgressCircle extends ConsumerStatefulWidget {
  const WishlistItemCardProgressCircle({
    super.key,
    required this.wishlistItem,
  });

  final WishListItem wishlistItem;

  @override
  ConsumerState<WishlistItemCardProgressCircle> createState() =>
      _WishlistItemCardProgressCircleState();
}

class _WishlistItemCardProgressCircleState
    extends ConsumerState<WishlistItemCardProgressCircle> {
  late ValueNotifier<double> valueNotifier;
  late Timer _timer;
  late double _totalSavedMoney;
  late bool _isCompleted;
  late bool _isBeingLoaded;

  @override
  void initState() {
    _calcTotalSavedMoney();
    _initIsCompleted();
    _initValueNotifier();
    _incrementTimer();
    super.initState();
  }

  void _initIsCompleted() {
    final itemIndex =
        ref.read(wishListItemsProvider).indexOf(widget.wishlistItem);

    if (itemIndex == 0) {
      if (_totalSavedMoney >= widget.wishlistItem.price) {
        _isCompleted = true;
        _isBeingLoaded = false;
      } else {
        _isCompleted = false;
        _isBeingLoaded = true;
      }

      return;
    }

    double itemAccCost = 0;
    for (var element in ref.read(wishListItemsProvider)) {
      itemAccCost += element.price;
      if (element.id == widget.wishlistItem.id) {
        break;
      }
    }

    if (_totalSavedMoney >= itemAccCost) {
      _isCompleted = true;
      _isBeingLoaded = false;
    } else {
      _isCompleted = false;
      if (_totalSavedMoney >= itemAccCost - widget.wishlistItem.price) {
        _isBeingLoaded = true;
      } else {
        _isBeingLoaded = false;
      }
    }
  }

  void _initValueNotifier() {
    if (_isCompleted) {
      valueNotifier = ValueNotifier(100);
      return;
    }

    if (!_isCompleted) {
      if (!_isBeingLoaded) {
        valueNotifier = ValueNotifier(0);
      } else {
        double itemAccCost = 0;
        for (var element in ref.read(wishListItemsProvider)) {
          if (element.id == widget.wishlistItem.id) {
            break;
          }
          itemAccCost += element.price;
        }
        final remainingTotalSaved = _totalSavedMoney - itemAccCost;
        setState(() {
          valueNotifier = ValueNotifier(
              remainingTotalSaved / widget.wishlistItem.price * 100);
        });
      }
    }
  }

  void _incrementTimer() {
    const duration = Duration(minutes: 1);
    _timer = Timer.periodic(duration, (timer) {
      final passedTime =
          DateTime.now().difference(ref.read(userProvider).first.start);
      final tempTotalSavedMoney = passedTime.inMinutes *
          ref.read(userProvider).first.savedMoneyPerMinute();
      if (tempTotalSavedMoney.toStringAsFixed(2) !=
          _totalSavedMoney.toStringAsFixed(2)) {
        _totalSavedMoney = tempTotalSavedMoney;
        _initIsCompleted();
        _initValueNotifier();
      }
    });
  }

  void _calcTotalSavedMoney() {
    final passedTime =
        DateTime.now().difference(ref.read(userProvider).first.start);
    _totalSavedMoney = passedTime.inMinutes *
        ref.read(userProvider).first.savedMoneyPerMinute();
  }

  @override
  void dispose() {
    _timer.cancel();
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleCircularProgressBar(
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
    );
  }
}
