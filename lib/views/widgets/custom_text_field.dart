import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    // super.key,
    Key? key, // Fix 1: Change super.key to Key key

    required this.hintText,
    required this.customFontSize,
    this.withoutPrefix = true,
    this.withoutSuffix = true,
    required this.controller,
    this.icon,
    this.textInputType = TextInputType.text,
    this.maxLine = 1,
    this.iconColor = const Color(0xff707070),
    this.paddingHor = 16,
    this.suffixIcon = Icons.info_outline,
    this.suffixFunction,
    this.isAddActivity = false,
    this.hintColor = kGreyWhiteColor,
    this.image,
    this.isSender = false,
    this.isDisable = false,
    this.validator,
    // this.backgrundColor = Colors.white
  });
  // this.backgrundColor = const Color(0xff707070)});

  final TextInputType? textInputType;
  final Color? iconColor;
  final Color hintColor;
  final int? maxLine;
  final String hintText;
  final double customFontSize;
  final int? paddingHor;
  final bool? withoutPrefix;
  final bool? withoutSuffix;
  final TextEditingController? controller;
  final Widget? icon;
  final IconData? suffixIcon;
  final Function()? suffixFunction;
  final bool? isAddActivity;
  final Widget? image;
  final bool? isSender;
  final bool? isDisable;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    //TODO: Add select the content of text field to copy or cut .....
    return Column(children: [
      TextFormField(
        controller: controller,
        maxLines: maxLine, //add more one line
        keyboardType: textInputType,
        validator: validator,

        style: const TextStyle(color: Color(0xff707070)),
        cursorColor: const Color(0xff707070),
        readOnly: isSender == true && isDisable == true ? true : false,
        decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(
              minWidth: 40.w,
              minHeight: 40.w,
            ),
            //filled: true, //<-- SEE HERE
            //fillColor: backgrundColor,

            contentPadding: withoutPrefix == true
                ? EdgeInsets.symmetric(horizontal: paddingHor!.w)
                : const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            focusedBorder: buildOutlineInputBorderTextField(),
            enabledBorder: buildOutlineInputBorderTextField(),
            prefixIcon: withoutPrefix == true ? null : icon,
            hintText: hintText,
            hintStyle:

            buildAppBarTextStyle(
                fontSizeController: customFontSize,

                color: hintColor,
                //TODO : Check below color !!!!!!
                // color: const Color(0xffafafaf),
                letterSpacing: 0.15),
            suffixStyle:
                withoutPrefix == true ? null : const TextStyle(height: 12),
            suffixIcon: withoutSuffix == true
                ? null
                : InkWell(
                    onTap: suffixFunction,
                    child: Icon(
                      suffixIcon,
                      color: kLightBlueColor,
                    ),
                  )),
      ),
    ]);
  }
}
