import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomChip extends StatefulWidget {
  CustomChip(
      {super.key,
      required this.text,
      this.isPressed = false,
      this.isHomeTag = false,
      required this.onPressed});
  final String text;
  bool isPressed;
  bool isHomeTag;
  final void Function() onPressed;
  //bool isSelected = false;
  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return RawChip(
      onPressed: () {
        setState(() {
          widget.isPressed = !widget.isPressed;
        });
        widget.onPressed();
      },
      label: Text(
        widget.text,
      ),
      backgroundColor: widget.isPressed ? kLightBlueColor : kLightGreyColor,
      labelStyle: tileTextNumberStyle.copyWith(
        color: widget.isPressed ? Colors.white : kDarkGreyColor,
      ),
    );
  }
}
