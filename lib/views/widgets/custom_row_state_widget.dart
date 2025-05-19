import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';
import 'custom_container.dart';

class CustomRowStateWidget extends StatefulWidget {
  final int index;
  final String text;
  final Function() onTap;
  final int selected;
  final bool checkTap;
  final Color? color;
  final bool isStatus;
  const CustomRowStateWidget(
      {super.key,
      required this.index,
      required this.text,
      required this.onTap,
      required this.selected,
      required this.checkTap,
      this.color,
      required this.isStatus});

  @override
  State<CustomRowStateWidget> createState() => _CustomRowStateWidgetState();
}

class _CustomRowStateWidgetState extends State<CustomRowStateWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        childContainer: Padding(
      padding: widget.index != 2 && widget.isStatus == false
          ? EdgeInsetsDirectional.only(start: 18.h)
          : EdgeInsets.zero,
      child: Column(
        children: [
          InkWell(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  widget.isStatus == true
                      ? Container(
                          margin: const EdgeInsets.only(right: 16),
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: widget.index == 2 && !widget.isStatus
                        ? const EdgeInsetsDirectional.only(start: 18.0)
                        : EdgeInsets.zero,
                    child: Text(
                      widget.text,
                      style: buildAppBarTextStyle(
                          color: kBlackColor,
                          fontSizeController: 16,
                          letterSpacing: 0.15),
                    ),
                  ),
                  const Spacer(),
                  widget.selected == widget.index
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(end: 19.0.w),
                          child: const Icon(
                            Icons.check,
                            size: 25,
                            color: kLightBlueColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          widget.isStatus
              ? widget.index != 3
                  ? Divider(
                      indent: 50.0.w,
                      thickness: 1.2,
                    )
                  : const SizedBox.shrink()
              : widget.index != 3 && widget.index != 2
                  ? Divider(
                      indent: 8.0.w,
                      thickness: 1.2,
                    )
                  : const SizedBox.shrink(),
          widget.index == 2 && !widget.isStatus
              ? const Divider(
                  thickness: 1.7,
                )
              : const SizedBox.shrink()
        ],
      ),
    ));
  }
}
