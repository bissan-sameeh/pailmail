import 'package:flutter/material.dart';

class CustomStatusContainer extends StatelessWidget {
  const CustomStatusContainer({
    super.key,
    required this.color,
    required this.size,
    this.child,
  });

  final Color color;
  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: child,
    );
  }
}
