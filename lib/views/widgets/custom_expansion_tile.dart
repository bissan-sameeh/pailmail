import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    super.key,
    required this.children,
    required this.widgetOfTile,
    this.isIndexWidet = false,
    this.mailNumber,
    this.isExpanded = true,
    this.index = 0,
    this.isEmpty = false,
  });

  final List<Widget> children;
  final bool isEmpty;
  final Widget widgetOfTile;
  final bool isIndexWidet;
  final String? mailNumber;
  final bool isExpanded;
  final int index;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _customTileExpanded = false;
  late TapGestureRecognizer _tapGestureRecognizer;
  void expandCollapse() {
    setState(() {
      _customTileExpanded = !_customTileExpanded;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = navigateToAllMail;
    super.initState();
  }

  navigateToAllMail() {
    if (!widget.isEmpty) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return AllCategoryMails(index: widget.index);
      //     },
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: !widget.isExpanded,
      childrenPadding: EdgeInsetsDirectional.zero,
      shape: const Border(),
      tilePadding: widget.isIndexWidet == false
          ? EdgeInsetsDirectional.only(
              start: 16.0.h,
            )
          : const EdgeInsetsDirectional.only(start: 0),
      onExpansionChanged: (bool expanded) async {
        expandCollapse();
      },
      title: widget.widgetOfTile,
      trailing: Padding(
        padding: !widget.isIndexWidet
            ? EdgeInsetsDirectional.only(end: 14.h)
            : EdgeInsetsDirectional.only(end: 0.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: !widget.isExpanded || !_customTileExpanded,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text(
                  //   widget.mailNumber ?? '',
                  //   //TODO : Style
                  //   style: buildAppBarTextStyle(
                  //       color: kMediumGreyColor,
                  //       fontSizeController: 14,
                  //       letterSpacing: 0.15),
                  // ),
                  RichText(
                    text: TextSpan(
                      text: widget.mailNumber ?? "",
                      recognizer: _tapGestureRecognizer,
                      style: const TextStyle(
                          color: kLightBlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            widget.isExpanded
                ? Icon(
                    _customTileExpanded
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.arrow_forward_ios_rounded,
                    size: _customTileExpanded ? 32 : 18,
                    color:
                        _customTileExpanded ? kLightBlueColor : kDarkGreyColor,
                    // weight: 12,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
      children: widget.children,
    );
  }
}
