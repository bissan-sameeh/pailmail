import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.widgetName,
      this.bottomPadding = 55,
      this.endPadding = 0,
      this.onTap,
      this.isEdit = false, this.trailing})
      : super(key: key);
  final String widgetName;
  final double bottomPadding;
  final double endPadding;
  final Function()? onTap;
  final bool? isEdit;
  final Widget? trailing;

//TODO: ADD underline for app bar
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: 16.0.h, bottom: bottomPadding, end: endPadding),
      //    padding: EdgeInsetsDirectional.only(top: 24.0.h, bottom: bottomPadding, end: endPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text("Cancel",
                  style: buildAppBarTextStyle(letterSpacing: 1.2))),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,

              widgetName,
              style: buildAppBarTextStyle(color: kBlackColor),
            ),
          ),
           InkWell(
            onTap: isEdit == false
                ? () {
                    Navigator.pop(context);
                  }
                : onTap,
            child: trailing ?? Text(
              //TODO: Handle on tap navigation
              "Done",
              style: buildAppBarTextStyle(),
            ),
          )  ,
        ],
      ),
    );
  }
}
