import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:desmokrizer/models/wish_list_item.dart';
import 'package:desmokrizer/provider/user_provider.dart';
import 'package:desmokrizer/provider/wishlist_items_provider.dart';

class WishlistItemCardRemainingText extends ConsumerStatefulWidget {
  const WishlistItemCardRemainingText({
    super.key,
    required this.wishlistItem,
  });

  final WishListItem wishlistItem;

  @override
  ConsumerState<WishlistItemCardRemainingText> createState() =>
      _WishlistItemCardRemainingTextState();
}

class _WishlistItemCardRemainingTextState
    extends ConsumerState<WishlistItemCardRemainingText> {
  late Timer _timer;
  late double _totalSavedMoney;
  Duration _remaining = Duration.zero;
  late bool _isCompleted;

  @override
  void initState() {
    _calcTotalSavedMoney();
    _initIsCompleted();
    _initRemaining();
    _incrementTimer();
    super.initState();
  }

  void _initRemaining() {
    if (_isCompleted) {
      _remaining = Duration.zero;
      return;
    }

    double accTotalSaved = 0;
    for (var element in ref.read(wishListItemsProvider)) {
      accTotalSaved += element.price;
      if (element.id == widget.wishlistItem.id) {
        break;
      }
    }

    final remainingMoney = accTotalSaved - _totalSavedMoney;
    final temp = Duration(
        minutes:
            remainingMoney ~/ ref.read(userProvider).savedMoneyPerMinute());
    if (temp != _remaining) {
      setState(() {
        _remaining = temp;
      });
    }
  }

  void _initIsCompleted() {
    final itemIndex =
        ref.read(wishListItemsProvider).indexOf(widget.wishlistItem);

    if (itemIndex == 0) {
      if (_totalSavedMoney >= widget.wishlistItem.price) {
        _isCompleted = true;
      } else {
        _isCompleted = false;
      }
      return;
    }

    double accTotalSaved = 0;
    for (var element in ref.read(wishListItemsProvider)) {
      accTotalSaved += element.price;
      if (element.id == widget.wishlistItem.id) {
        break;
      }
    }

    if (_totalSavedMoney >= accTotalSaved) {
      _isCompleted = true;
    } else {
      _isCompleted = false;
    }
  }

  void _incrementTimer() {
    const duration = Duration(minutes: 1);
    _timer = Timer.periodic(duration, (timer) {
      final passedTime =
          DateTime.now().difference(ref.read(userProvider).start);
      final tempTotalSavedMoney =
          passedTime.inMinutes * ref.read(userProvider).savedMoneyPerMinute();
      if (tempTotalSavedMoney.toStringAsFixed(2) !=
          _totalSavedMoney.toStringAsFixed(2)) {
        _totalSavedMoney = tempTotalSavedMoney;
        _initIsCompleted();
        _initRemaining();
      }
    });
  }

  String _calcRemaining() {
    final remainingDays = _remaining.inDays;
    final years = remainingDays ~/ 365;
    final months = (remainingDays - years * 365) ~/ 30;
    final weeks = (remainingDays - years * 365 - months * 30) ~/ 7;
    final days = (remainingDays - years * 365 - months * 30 - weeks * 7);
    final hours = (_remaining.inHours -
        years * 365 * 24 -
        months * 30 * 24 -
        weeks * 7 * 24 -
        days * 24);
    final minutes = (_remaining.inMinutes -
        years * 365 * 24 * 60 -
        months * 30 * 24 * 60 -
        weeks * 7 * 24 * 60 -
        days * 24 * 60 -
        hours * 60);

    return "${years > 0 ? "$years" "y" : ""} ${months > 0 ? "$months" "m" : ""} ${weeks > 0 ? "$weeks" "w" : ""} ${years > 0 ? "" : "$days" "d"} ${years > 0 || months > 0 ? "" : "$hours" "h"} ${years > 0 || months > 0 || weeks > 0 ? "" : "$minutes" "m"}";
  }

  void _calcTotalSavedMoney() {
    final passedTime = DateTime.now().difference(ref.read(userProvider).start);
    _totalSavedMoney =
        passedTime.inMinutes * ref.read(userProvider).savedMoneyPerMinute();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _isCompleted ? "Completed" : _calcRemaining(),
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 12,
          ),
    );
  }
}
