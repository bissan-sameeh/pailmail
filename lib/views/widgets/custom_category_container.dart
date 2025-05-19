import 'package:pailmail/views/widgets/custom_status_container.dart';
import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomMailCategoryContainer extends StatelessWidget {
  const CustomMailCategoryContainer(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.number,
      this.endMargin = 0,
      required this.color})
      : super(key: key);
  final Function() onTap;
  final String text;
  final String number;
  final double endMargin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    //TODO tap:
    return Container(
      margin: EdgeInsetsDirectional.only(end: endMargin),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              color: Color.fromARGB(77, 205, 204, 241),
              blurRadius: 4),
        ],
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomStatusContainer(
                        color: color,
                        size: 24,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        text,
                        style: statusTextStyle,
                      ),
                    ],
                  ),
                ),
                Text(
                  number.toString(),
                  style: statusTextStyle.copyWith(
                      fontSize: 20, color: kBlackColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
