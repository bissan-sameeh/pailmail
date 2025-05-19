import 'package:pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:pailmail/providers/status_provider.dart';
import 'package:pailmail/views/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/custom_list_row_state.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: MediaQuery.of(context).size.height-45.h,
        child: Padding(
          padding:
              EdgeInsets.only(top: 20.0.h, left: 20.w, right: 20.w, bottom: 62.h),
          child: Column(children: [
            ///app Bar
            const CustomAppBar(
              widgetName: 'Status',
            ),
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: 19.w, top: 20.h, bottom: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.sp),
                  color: Colors.white),
              child: Column(
                children: [
                  ///Add State
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 19.0.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add Status",
                            style: buildAppBarTextStyle(
                                fontSizeController: 16, letterSpacing: 0.15),
                          ),
                          const Icon(
                            Icons.edit_outlined,
                            color: Color(0xffAFAFAF),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 19.h,
                  ),
                  // Consumer<StatusProvider>(
                  //     builder: (context, statusProvider, child) {
                  //   if (statusProvider.allStatus.status == ApiStatus.LOADING) {
                  //     return const CircularProgressIndicator();
                  //   } else if (statusProvider.allStatus.status ==
                  //       ApiStatus.COMPLETED) {
                  //     if (statusProvider.allStatus.data!.isEmpty) {
                  //       return const Column(
                  //         children: [Icon(Icons.warning), Text("No Data")],
                  //       );
                  //     } else {
                  //       final status = statusProvider.allStatus.data!;
                  //       return CustomListRowState(
                  //         statusList: status,
                  //         isStatus: true,
                  //         color: status,
                  //       );
                  //     }
                  //   } else {
                  //     return Text(statusProvider.allStatus.message.toString());
                  //   }
                  // })

                  Consumer<StatusProvider>(
                    builder: (BuildContext context, StatusProvider statusProvider,
                        Widget? child) {
                      if (statusProvider.allStatus.status == ApiStatus.LOADING) {
                        return const Center(child: spinkit);
                      }
                      if (statusProvider.allStatus.status ==
                          ApiStatus.COMPLETED) {
                        if (statusProvider.allStatus.data!.isEmpty) {
                          return const Column(
                            children: [Icon(Icons.warning), Text("No Data")],
                          );
                        } else {
                          ///view and select status

                          final status = statusProvider.allStatus.data!;
                          return CustomListRowState(
                            statusList: status,
                            isStatus: true,
                            color: status,
                          );
                        }
                      } else {
                        return Text(statusProvider.allStatus.message.toString());
                      }
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),

    );
  }

// int isSelected = 0;

// int count = 0;
//
// Widget _CustomStatusRowState(
//     {required String statusText, required Color color, required int index}) {
//   return Column(
//     children: [
//       InkWell(
//         onTap: () => setState(() {
//           isSelected = index;
//         }),
//         child: Row(
//           children: [
//             Opacity(
//               opacity: 1.0,
//               child: Container(
//                 margin: const EdgeInsets.only(right: 16),
//                 width: 32.w,
//                 height: 32.w,
//                 decoration: BoxDecoration(
//                   color: color,
//                   borderRadius: BorderRadius.circular(10.r),
//                 ),
//               ),
//             ),
//             Text(
//               statusText,
//               style: buildAppBarTextStyle(
//                   color: kBlackColor,
//                   fontSizeController: 16,
//                   letterSpacing: 0.15),
//             ),
//             const Spacer(),
//             isSelected == index
//                 ? Padding(
//                     padding: EdgeInsetsDirectional.only(end: 19.0.w),
//                     child: const Icon(
//                       Icons.check,
//                       size: 35,
//                       color: kLightBlueColor,
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ],
//         ),
//       ),
//       index != 3
//           ? Divider(
//               indent: 50.0.w,
//               thickness: 1.2,
//             )
//           : const SizedBox.shrink()
//     ],
//   );
// }
}
