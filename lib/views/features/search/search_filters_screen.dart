import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../../models/statuses/status.dart';
import '../../../providers/status_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_date_container.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({Key? key}) : super(key: key);

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  DateTime? _selectedFromDate = DateTime.now();
  DateTime? _selectedToDate = DateTime.now();
  int selected = -1;
  bool checkTap = false;
  late List<Status>? colors;
  clear() {
    Provider.of<StatusProvider>(context, listen: false).index = -1;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var status = Provider.of<StatusProvider>(context).allStatus.data;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              top: 20.0.h, start: 20.w, end: 20.w, bottom: 62.h),
          child: Column(
            children: [
              CustomAppBar(
                isEdit: true,
                onTap: () {
                  print('-------------+++++++++++++ $selected');
                  Navigator.pop(context, (selected + 1).toString());
                },
                widgetName: 'Filters',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ///Add State
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 19.0.w),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              //todo: apply clear filter
                              selected = -1;
                            });
                          },
                          child: Text(
                            "Clear Filter",
                            style: buildAppBarTextStyle(
                                color: kMediumGreyColor,
                                fontSizeController: 16,
                                letterSpacing: 0.15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    status == null
                        ? spinkit
                        : Container(
                            margin:
                                EdgeInsetsDirectional.symmetric(vertical: 20.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return CustomContainer(
                                    childContainer: Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 18.h),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = index;
                                            checkTap = true;
                                            print(
                                                '-------------select $selected');
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 16),
                                                width: 32.w,
                                                height: 32.w,
                                                decoration: BoxDecoration(
                                                  color: Color(int.parse(
                                                      status[index]
                                                          .color
                                                          .toString())),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.zero,
                                                child: Text(
                                                  status[index].name ?? 'inbox',
                                                  style: buildAppBarTextStyle(
                                                      color: kBlackColor,
                                                      fontSizeController: 16,
                                                      letterSpacing: 0.15),
                                                ),
                                              ),
                                              const Spacer(),
                                              checkTap && selected == index
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .only(
                                                                  end: 19.0.w),
                                                      child: const Icon(
                                                        Icons.check,
                                                        size: 30,
                                                        color: kLightBlueColor,
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      index != 3
                                          ? Divider(
                                              indent: 50.0.w,
                                              thickness: 1.2,
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ));
                              },
                              // itemCount: widget.list != null || widget.statusList != null
                              //     ? widget.isStatus
                              //         ? widget.statusList!.length
                              //         : widget.list!.length
                              //     : 0,
                              itemCount: status.length,

                              shrinkWrap: true,
                            ),
                          ),
                  ],
                ),
              ),
              CustomDateContainer(
                title: 'From Date',
                selectedDate: _selectedFromDate!,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomDateContainer(
                title: 'To Date',
                selectedDate: _selectedToDate!,
                isFilterScreen: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // }
}
