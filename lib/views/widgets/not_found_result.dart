import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class NotFoundResult extends StatelessWidget {
  const NotFoundResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          children: [

            Image.asset('assets/images/not_found.jpg'),
            SizedBox(height: 12.h,),
            Text(

              'No Result Found !',
              style: buildAppBarTextStyle(
                fontSizeController: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
