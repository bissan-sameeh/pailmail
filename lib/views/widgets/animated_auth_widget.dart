import 'package:flutter/material.dart';
import 'custom_text_forn_field_widget.dart';

class AnimatedAuthWidget extends StatelessWidget {
  const AnimatedAuthWidget({
    super.key,
    required this.textEditingController,
    required this.condition,
  });

  final CustomTextFormFieldWidget textEditingController;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 500),
      firstChild: textEditingController,
      secondChild: const SizedBox(),
      crossFadeState:
      condition ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
