import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';
import 'custom_profile_image.dart';

class CustomProfileContainerImage extends StatelessWidget {
  const CustomProfileContainerImage({
    super.key,
    required this.userImage,
  });

  final String? userImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 224.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 100.h),
            decoration: BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.r),
                  bottomRight: Radius.circular(50.r),
                )),
          ),
          Align(
            alignment: Alignment.center,
            // child: CustomProfileImage(image: '$userImage'),
            child: CustomProfileImage(
              image: NetworkImage('$imageUrl/$userImage'),
            ),
          )
        ],
      ),
    );
  }
}
