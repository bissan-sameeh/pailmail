import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomOtlinedButton extends StatelessWidget {
  final Widget child;
  const CustomOtlinedButton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: const ButtonStyle().copyWith(
          shape: const MaterialStatePropertyAll(
            CircleBorder(),
          ),
          side: const MaterialStatePropertyAll(
            BorderSide(color: kLightGreyColor),
          ),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(12))),
      child: child,
    );
  }
}
