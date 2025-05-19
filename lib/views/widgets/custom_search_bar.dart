import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pailmail/core/helpers/routers/router.dart';

import '../../core/utils/constants.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar(
      {Key? key, this.onTap, this.searchController, this.isSenderPage = false})
      : super(key: key);
  final Function(String)? onTap;
  final bool isSenderPage;

  final TextEditingController? searchController;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
          top: 4.h, bottom: 4.h, start: 20.w, end: 13.w),
      decoration: BoxDecoration(
          // color: const Color(0xffE6E6E6),
          color: Colors.white,
          borderRadius: BorderRadius.circular(24)),
      child: TextField(
        controller: widget.isSenderPage == true ? widget.searchController : null,
        onChanged: widget.onTap,
        decoration: InputDecoration(
          contentPadding: EdgeInsetsDirectional.zero,
          prefixIcon: const Icon(
            Icons.search,
            size: 30,
            color: kMediumGreyColor,
          ),
          suffixIcon: Transform.scale(
            scale: 0.7, // Adjust the scale factor as needed
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffafafaf),
              ),
              child: GestureDetector(
                onTap: () {
                  widget.isSenderPage == true ? widget.searchController?.text='':null;
                  setState(() {

                  });
                } ,
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          hintText: "Search sender",
          hintStyle:
              buildAppBarTextStyle(fontSizeController: 14, color: kBlackColor),
          focusedBorder: buildOutlineInputBorderTextField(),
          enabledBorder: buildOutlineInputBorderTextField(),
        ),
      ),
    );
  }
}
