import 'package:pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:pailmail/core/helpers/routers/router.dart';
import 'package:pailmail/providers/categories_providers/categories_provider.dart';
import 'package:pailmail/providers/sender_provider.dart';

import 'package:pailmail/repositories/sender_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/utils/awesome_dialog.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/not_found_result.dart';

class SenderScreen extends StatefulWidget {
  const SenderScreen({super.key});

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> with AwesomeDialogMixin{
  SenderRepository sn = SenderRepository();
  bool isCheck = false;
  bool iSearch = false;
  late int index = -1;
  int categoryIndex = -1;
  late TextEditingController searchController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
    Provider.of<CategoriesProvider>(context,listen: false).fetchAllCategories();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      ///App Bar
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              top: 20.0.h, start: 20.w, bottom: 62.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                onTap: () {
                  if (categoryIndex != -1) {
                    isCheck = true;

                    Provider.of<CategoriesProvider>(context, listen: false).setCategoryIndex(categoryIndex: categoryIndex);
                    setState(() {
                    });
                  Navigator.pop(context, isCheck);
                  }else{
                    buildWarningDialog(context, 'Choice Sender!', () => NavigationRoutes().pop(context),);
                  }
                },
                widgetName: 'Sender',
                isEdit: true,
                endPadding: 27.w,
                bottomPadding: 15.h,
              ),

              ///Search Bar
              Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: CustomSearchBar(
                  isSenderPage: true,
                  searchController: searchController,
                  onTap: (input) async {
                    setState(() {});

                  },
                ),
              ),

              ///Text of Search

              searchController.text.isNotEmpty ?
              Container(
                  width: double.infinity,
                  margin: EdgeInsetsDirectional.only(top: 24.h),
                  padding: EdgeInsetsDirectional.symmetric(
                    vertical: 20.h,
                  ),
                  decoration: buildBoxDecoration(),
                  child: Text(searchController.text,
                      style: buildAppBarTextStyle(
                          color: kBlackColor, fontSizeController: 14.sp))) :
              const SizedBox.shrink(),
              buildListViewOfSendersContainers()
            ],
          ),
        ),
      ),
    );
  }

  Consumer<CategoriesProvider> buildListViewOfSendersContainers() {
    return Consumer<CategoriesProvider>(
      builder: (context, categoriesProvider, child) {
        if (categoriesProvider.allCategories.status == ApiStatus.COMPLETED) {
          final categories = categoriesProvider.allCategories.data!;
          List<Map<String, dynamic>> allFilteredSenders = [];

          for (int i = 0; i < categories.length; i++) {
            final category = categories[i];
            final filteredSenders = (category.senders ?? []).where((sender) =>
                sender.name!.toLowerCase().contains(searchController.text.toLowerCase())).toList();

            if (filteredSenders.isNotEmpty) {
              allFilteredSenders.add({
                'category': category,
                'senders': filteredSenders,
                'categoryIndex': i,
              });
            }
          }
          //اذا البيانات فاضية

          if (searchController.text.isNotEmpty && allFilteredSenders.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: const NotFoundResult()
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allFilteredSenders.length,
            itemBuilder: (context, index1) {
              final category = allFilteredSenders[index1]['category'];
              final senderList = allFilteredSenders[index1]['senders'];
              final catIndex = allFilteredSenders[index1]['categoryIndex'];

              return Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Category Title
                    Padding(
                      padding: EdgeInsets.only(top: 23.0, bottom: 4.h),
                      child: Text(
                        category.name.toString(),
                        style: buildAppBarTextStyle(
                          fontSizeController: 12,
                          color: const Color(0xffafafaf),
                        ),
                      ),
                    ),

                    /// Sender List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: senderList.length,
                      itemBuilder: (context, indexSender) {
                        final sender = senderList[indexSender];
                        return Container(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 20.h),
                          decoration: buildBoxDecoration(),
                          child: InkWell(
                            onTap: () {
                              index = indexSender;
                              categoryIndex = catIndex;
                              print("category index $categoryIndex index $index");

                              Provider.of<CategoriesProvider>(context, listen: false)
                                  .setSenderIndex(selectedIndex: indexSender);
                              Provider.of<CategoriesProvider>(context, listen: false)
                                  .setCategoryIndex(categoryIndex: categoryIndex);
                            },
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 1.5,
                                  child: Container(
                                    margin: EdgeInsetsDirectional.only(end: 8.h),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kDarkGreyColor,
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sender.name.toString(),
                                      style: buildAppBarTextStyle(
                                        fontSizeController: 14,
                                        color: kBlackColor,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      sender.mobile.toString(),
                                      style: buildAppBarTextStyle(
                                        fontSizeController: 14,
                                        color: kBlackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }

        if (categoriesProvider.allCategories.status == ApiStatus.LOADING) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Skeletonizer(
                enabled: true,
                child: ListTile(
                  leading: CircleAvatar(radius: 20.r),
                  title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Category'),
                      Divider(),
                      Text('Sender Name'),
                    ],
                  ),
                  subtitle: const Text("Phone"),
                ),
              );
            },
          );
        }

        return Text(categoriesProvider.allCategories.message.toString());
      },
    );
  }

}
