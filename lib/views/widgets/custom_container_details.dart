import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class CustomContainerDetails extends StatefulWidget {
  const CustomContainerDetails(
      {super.key,
      required this.organizationName,
      required this.organizationCategory,
      required this.dateOrgName,
      required this.dateOrgCategory,
      required this.subject,
      required this.onPress});

  final String organizationName;
  final String organizationCategory;
  final String dateOrgName;
  final String dateOrgCategory;
  final Widget subject;
  final Function onPress;

  @override
  State<CustomContainerDetails> createState() => _CustomContainerDetailsState();
}

class _CustomContainerDetailsState extends State<CustomContainerDetails> {
  double? Hight;

  @override
  Widget build(BuildContext context) {
    //Todo:Modification  Container
    return Container(
      width: 378.w,
      // height: 190.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30.r),
        child: Padding(
          padding:
              EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////icon
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Name org....
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 15.0, end: 8),
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: kGreyWhiteColor,
                          size: 20,
                        ),
                      ),
                      Text(
                        widget.organizationName,
                        style: tileTextTitleStyle.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),

                  Text(
                    widget.dateOrgName,
                    style: tileTextNumberStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //date and icon
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15.0),
                    child: Text(
                      widget.organizationCategory,
                      style: tileTextTitleStyle.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.normal),
                    ),
                  ),

                  Text(
                    widget.dateOrgCategory,
                    style: tileTextNumberStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                height: 12.h,
                thickness: 1,
                color: kLightGreyColor,
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 3.0, end: 3),
                child: widget.subject,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
