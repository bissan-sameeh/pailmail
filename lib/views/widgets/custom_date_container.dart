import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';
import 'custom_container.dart';
import 'custom_divider.dart';
import 'custom_expansion_tile.dart';

class CustomDateContainer extends StatefulWidget {
  final String title;
  DateTime selectedDate;
  final bool isFilterScreen;
  final Widget? archiveWidget;
  CustomDateContainer({
    Key? key,
    required this.title,
    required this.selectedDate,
    this.isFilterScreen = true,
    this.archiveWidget,
  }) : super(key: key);

  @override
  State<CustomDateContainer> createState() => _CustomDateContainerState();
}

class _CustomDateContainerState extends State<CustomDateContainer> {
  modifyDate() {}
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        childContainer: Padding(
      padding: widget.isFilterScreen == true
          ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h)
          : EdgeInsets.symmetric(horizontal: 0.w, vertical: 12.h),
      child: Column(children: [
        CustomExpansionTile(
          isIndexWidet: true,
          widgetOfTile: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: kRedColor,
                    size: 25,
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: buildAppBarTextStyle(
                            color: kBlackColor,
                            letterSpacing: 0.15,
                            fontSizeController: 16),
                      ),
                      Text(
                        //20.20.2022
                        "${widget.selectedDate}".split(" ")[0],
                        style: buildAppBarTextStyle(
                            letterSpacing: 0.15, fontSizeController: 12),
                      ),
                      widget.isFilterScreen == true
                          ? const CustomDivider()
                          : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ],
          ),
          children: [
            widget.isFilterScreen == true
                ? const CustomDivider()
                : const SizedBox.shrink(),
            Column(
              children: [
                CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                    onDateChanged: (_) {
                      setState(() {
                        widget.selectedDate = _;
                      });
                    })
              ],
            ),
          ],
        ),
        !widget.isFilterScreen
            ? const CustomDivider()
            : const SizedBox.shrink(),
        if (!widget.isFilterScreen && widget.archiveWidget != null)
          widget.archiveWidget!,
      ]),
    ));
  }
}
