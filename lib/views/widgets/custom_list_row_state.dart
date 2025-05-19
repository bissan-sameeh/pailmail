import 'package:pailmail/models/categories/category_response_model.dart';
import 'package:pailmail/providers/categories_providers/categories_provider.dart';

import 'package:pailmail/models/statuses/status.dart';
import 'package:pailmail/providers/status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'custom_row_state_widget.dart';

class CustomListRowState<T> extends StatefulWidget {
  const CustomListRowState(
      {Key? key,
      this.list,
      this.statusList,
      required this.isStatus,
      this.color})
      : super(key: key);
  final List<CategoryElement>? list;
  final List<Status>? statusList;

  final bool isStatus;
  final List<Status>? color;

  @override
  State<CustomListRowState> createState() => _CustomListRowStateState();
}

class _CustomListRowStateState extends State<CustomListRowState> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    int selectedIndex =
        Provider.of<StatusProvider>(context, listen: true).index;
    int selectedCategoryIndex =
        Provider.of<CategoriesProvider>(context, listen: true).categoryPosition;

    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CustomRowStateWidget(
            index: index,
            text: widget.isStatus
                ? widget.statusList![index].name!
                : widget.list![index].name!,
            onTap: () {
              setState(() {
                widget.isStatus?  selectedIndex = index :selectedCategoryIndex =index ;
                print(selectedIndex);
                check = true;
                widget.isStatus
                    ? Provider.of<StatusProvider>(context, listen: false)
                        .changeStatus(selectedIndex: selectedIndex)
                    : Provider.of<CategoriesProvider>(context, listen: false)
                        .setCategoryIndex(categoryIndex: selectedCategoryIndex);
              });
            },
            color: widget.isStatus
                ? Color(int.parse(widget.color![index].color.toString()))
                : null,
            selected: widget.isStatus ?selectedIndex :selectedCategoryIndex,
            checkTap: true,
            isStatus: widget.isStatus,
          );
        },
        itemCount:
            widget.isStatus ? widget.statusList!.length : widget.list!.length,
        shrinkWrap: true,
      ),
    );
  }
}
