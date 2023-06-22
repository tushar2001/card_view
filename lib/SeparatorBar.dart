import 'package:flutter/material.dart';

class SeparatorBar extends StatelessWidget {
  const SeparatorBar({
    super.key,
    required this.secondaryColor,
  });

  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 20,
      child: Text(
        '|',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: secondaryColor,
        ),
      ),
    );
  }
}
