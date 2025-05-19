import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin MyShowBottomSheet {
  showSheet(BuildContext context, Widget widget,{double height=0.95}) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.r), topLeft: Radius.circular(25.r)),
      ),
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: height, // 45% من ارتفاع الشاشة
          child: widget,
        );
      },
    );
  }
}
