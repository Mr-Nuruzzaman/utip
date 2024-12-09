import 'package:flutter/material.dart';

class TipCount extends StatelessWidget {
  const TipCount({
    super.key,
    required this.theme,
    required this.total,
    required int personCount,
    required double billTotal,
  })  : _personCount = personCount,
        _billTotal = billTotal;

  final ThemeData theme;
  final double total;
  final int _personCount;
  final double _billTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tip',
          style: theme.textTheme.titleMedium,
        ),
        Text(
          ((total * _personCount) - _billTotal).toStringAsFixed(2),
          style: theme.textTheme.titleMedium,
        )
      ],
    );
  }
}
