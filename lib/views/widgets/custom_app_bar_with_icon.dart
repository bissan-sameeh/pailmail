import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pailmail/core/helpers/routers/router.dart';
import 'package:pailmail/repositories/sender_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/utils/awesome_dialog.dart';
import '../../core/utils/constants.dart';
import '../../providers/categories_providers/category_mail_provider.dart';
import '../../providers/status_provider.dart';

class CustomAppBarWithIcon extends StatefulWidget {
  const CustomAppBarWithIcon(
      {Key? key,
      required this.widgetName,
      required this.left_icon,
      required this.right_icon,
      this.bottomPadding = 55,
      this.endPadding = 0,
      required this.id})
      : super(key: key);
  final String widgetName;
  final double bottomPadding;
  final double endPadding;
  final IconData left_icon;
  final IconData right_icon;
  final int? id;

  @override
  State<CustomAppBarWithIcon> createState() => _CustomAppBarWithIconState();
}

class _CustomAppBarWithIconState extends State<CustomAppBarWithIcon> with AwesomeDialogMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: 16.0.h, bottom: widget.bottomPadding, end: widget.endPadding),
      //    padding: EdgeInsetsDirectional.only(top: 24.0.h, bottom: bottomPadding, end: endPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(widget.left_icon, color: kLightBlueColor))
          // Text("Cancel", style: buildAppBarTextStyle()),
          ,
          Text(widget.widgetName,
              style: buildAppBarTextStyle(color: kBlackColor)),
          GestureDetector(
            child: Icon(
              widget.right_icon,
              color: kLightBlueColor,
            ),
            onTap: () {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                  context: context,
                  builder: (ctx) => Container(
                    // height: 270.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: kLightGreyColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.widgetName,
                                style: buildAppBarTextStyle(color: kBlackColor),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: kGreyWhiteColor),
                                child: InkWell(
                                  onTap: () => Navigator.pop(ctx),
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 33.h,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor),
                                  child: Padding(
                                    padding: REdgeInsetsDirectional.all(31.h),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.archive,
                                          color: kDarkGreyColor,
                                        ),
                                        SizedBox(height: 4.h,),
                                        const Text("archive"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                child: Container(
                                  // padding: REdgeInsetsDirectional.all(33.h),

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor),
                                  child: Padding(
                                    padding: REdgeInsetsDirectional.all(33.h),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.share,
                                          color: kLightBlueColor,
                                        ),
                                        SizedBox(height: 4.h,),

                                        const Text("share"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                child: Container(

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kWhiteColor),
                                  child: Padding(
                                    padding: REdgeInsetsDirectional.all(33.h),
                                    child: InkWell(
                                      onTap: () async {
                                        showDeleteConfirmationDialog(context,widget.id!);
                                
                                
                                      }
                                          // print('Error deleting sender: $e');
                                          // عرض رسالة خطأ للمستخدم هنا
                                
                                
                                      ,
                                
                                
                                      child:  Column(
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            color: kRedColor,
                                          ),
                                          SizedBox(height: 4.h,),
                                
                                          const Text("delete"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ));
              // _show(context, widget.widgetName, widget.id!);
            },
          )

          // Text(
          //   "Done",
          //   style: buildAppBarTextStyle(),
          // ),
        ],
      ),
    );
  }
}
void showDeleteConfirmationDialog(BuildContext context, int id) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.topSlide,
    title: 'Delete This Sender!',
    desc: 'Are you sure you want to delete this sender?',
    btnCancelOnPress: () {},
    btnOkOnPress: () async {
      SenderRepository repository = SenderRepository();

      try {
        await repository.deleteSender(id);

        final successDialog = AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          title: 'Deleted',
          desc: 'Sender was deleted successfully!',
          autoHide: const Duration(seconds: 2), // 2 ثواني (أنصح 2 ثواني مش دقيقتين لتجربة أفضل)
          onDismissCallback: (type) {
            refresh(context);
            Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              Routes.home_screen,
                  (route) => false,
              arguments: {'refresh': true},
            );
          },
        );

        successDialog.show();
      } catch (e) {
        print('Error deleting sender: $e');
      }
    },
  ).show();
}

refresh(BuildContext context) {
  var provider=Provider.of<CategoryMailProvider>(context,listen: false);
  var statusProvider=Provider.of<StatusProvider>(context,listen: false);
  provider. fetchCategoryMails(categoryId: "2", index: 0);
  provider. fetchCategoryMails(categoryId: "3", index: 1);
  provider. fetchCategoryMails(categoryId: "4", index: 2);
  provider. fetchCategoryMails(categoryId: "1", index: 3);
  statusProvider.fetchAllStatus();
}
