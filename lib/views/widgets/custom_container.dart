import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatefulWidget {
  const CustomContainer({
    Key? key,
    required this.childContainer,
    this.backgroundColor,
    this.isInBox = false,
  }) : super(key: key);
  final Widget childContainer;
  final Color? backgroundColor;
  final bool? isInBox;

  @override
  State<CustomContainer> createState() => _ContainerCustomState();
}

class _ContainerCustomState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 4.0.h, bottom: 4.h, left: 11.w, right: 11.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color:
              widget.isInBox == true ? widget.backgroundColor : Colors.white),
      child: widget.childContainer,
    );
  }
}
