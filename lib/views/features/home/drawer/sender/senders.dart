import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pailmail/core/utils/show_bottom_sheet.dart';
import 'package:pailmail/providers/categories_providers/categories_provider.dart';
import 'package:pailmail/providers/sender_provider.dart';
import 'package:pailmail/repositories/sender_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/helpers/api_helpers/api_response.dart';
import '../../../../../core/utils/awesome_dialog.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_form_widget.dart';
import '../../../../widgets/custom_search_bar.dart';
import 'SenderMalisScreen.dart';

class Senders extends StatefulWidget {
  const Senders({Key? key}) : super(key: key);

  @override
  State<Senders> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<Senders>
    with MyShowBottomSheet, AwesomeDialogMixin {
  // int selindex;
  late TextEditingController senderController;
  String? _selectedCountry;
  bool isInitial = true;

  String? _selectedCategoryName;

  late TextEditingController phoneController;
  late TextEditingController cityController;
  late SenderRepository repository;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState    super.initState();
    phoneController = TextEditingController();
    senderController = TextEditingController();
    cityController = TextEditingController();
    SenderRepository();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
    senderController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future<Sender?>? datas;    // String? name;
    return Scaffold(
        backgroundColor: kBackgroundColor,

        ///App Bar
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
                top: 20.0.h, start: 20.w, bottom: 62.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomAppBar(



                onTap: () {
                  Navigator.pop(context);
                },
                widgetName: 'Sender',
                endPadding: 27.w,
                bottomPadding: 15.h,
                trailing:    InkWell(
                    onTap: () {
                      showSheet(context, const SenderFormWidget(isEdit: false,));
                    },
                    child: const Icon(Icons.add,color: kLightBlueColor,size: 30,)),
              ),

              ///Search Bar
              Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: const CustomSearchBar(),
              ),

              ///Text of Search              ///

              buildListViewOfSendersContainers()
            ]),
          ),
        ));
  }

  _editSender({
    required String name,
    required String senderMobileHint,
    required String cityName,
    required String categoryName,
    required int category_id,
    required int sender_id,
  }) {
    String selectedCategoryName = categoryName;
    int? categoryId = category_id;
    senderController.text = name;
    phoneController.text = senderMobileHint;
    cityController.text =   cityName ;

    return SenderFormWidget(isEdit: true,initialCategoryId: categoryId,initialCategoryName: selectedCategoryName,initialCity: cityName, initialPhone: senderMobileHint,initialName: name,senderId: sender_id,);
  }

  Consumer<CategoriesProvider> buildListViewOfSendersContainers() {
    return Consumer<CategoriesProvider>(
      builder: (context, categoryProvider, child) {
        if (categoryProvider.allCategories.status == ApiStatus.COMPLETED) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index1) {
                final category = categoryProvider.allCategories.data![index1];
                int? selectedCategoryId;
                selectedCategoryId = category.id;
                print("category name ${category.name}");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Company Name
                    Padding(
                      padding: EdgeInsets.only(top: 23.0, bottom: 4.h),
                      child: Text(
                        category.name.toString(),
                        style: buildAppBarTextStyle(
                            fontSizeController: 12,
                            color: const Color(0xffafafaf)),
                      ),
                    ),

                    ///sender convert it to future builder
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexSender) {
                          return InkWell(
                            onTap: () {
                              Provider.of<SenderProvider>(context,
                                      listen: false)
                                  .getMailsOfSenderList(
                                      id: category.senders![indexSender].id
                                          .toString())
                                  .then((value) {
                                var stauts = Provider.of<SenderProvider>(
                                        context,
                                        listen: false)
                                    .mailOfSenderList;
                                // }
                                if (stauts.status == ApiStatus.COMPLETED) {
                                  var mails = stauts.data!;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SenderMailsScreen(
                                        mailsList: mails,
                                        sender: category.senders![indexSender],
                                      ),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                  vertical: 20.h),
                              decoration: buildBoxDecoration(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.5,
                                        // Adjust the scale factor as needed
                                        child: Container(
                                          margin: EdgeInsetsDirectional.only(
                                              end: 8.h),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: kDarkGreyColor,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 20.r,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        category.senders![indexSender].name
                                            .toString(),
                                        style: buildAppBarTextStyle(
                                            fontSizeController: 14,
                                            color: kBlackColor),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 8.0),
                                    child: PopupMenuButton<String>(
                                      icon:
                                          const Icon(Icons.more_vert_outlined),
                                      onSelected: (value) async {
                                        print("editttttttttttttt");

                                        if (value == 'edit') {
                                          _selectedCountry = category
                                                  .senders![indexSender]
                                                  .address ??
                                              '';
                                          var senderName = category
                                                  .senders![indexSender]
                                                  .name ??
                                              '';
                                          _selectedCategoryName =
                                              category.name ?? '';
                                          print("editttttttttttttt $_selectedCategoryName");
                                          print("editttttttttttttt $senderName")
                                          ;
                                          try {
                                            showSheet(
                                              context,
                                              SenderFormWidget(
                                                isEdit: true,
                                                initialName: senderName,
                                                senderId:  category
                                                    .senders![indexSender]
                                                    .id,
                                                initialCity: _selectedCountry,
                                                initialCategoryName: _selectedCategoryName,
                                                initialCategoryId: category.id,
                                                initialPhone: category.senders![indexSender].mobile!,
                                              ),
                                              height: .80,
                                            );
                                          } catch (e) {
                                            print("Error showing bottom sheet: $e");
                                          }

                                        } else if (value == 'delete') {
                                          try {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.warning,
                                              animType: AnimType.topSlide,
                                              title: 'Delete This Sender!',
                                              desc:
                                                  'Are you sure you want to delete this sender?',
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () async {
                                                SenderRepository repository =
                                                    SenderRepository();

                                                try {
                                                  await repository.deleteSender(
                                                      category
                                                          .senders![indexSender]
                                                          .id!);

                                                  final successDialog =
                                                      AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.success,
                                                    animType: AnimType.topSlide,
                                                    title: 'Deleted',
                                                    desc:
                                                        'Sender was deleted successfully!',
                                                    autoHide: const Duration(
                                                        seconds: 2),
                                                    onDismissCallback: (type) {
                                                      Provider.of<CategoriesProvider>(
                                                              context,
                                                              listen: false)
                                                          .fetchAllCategories();
                                                    },
                                                  );

                                                  successDialog.show();
                                                } catch (e) {
                                                  print(
                                                      'Error deleting sender: $e');
                                                }
                                              },
                                            ).show();
                                          } catch (e) {
                                            print('Error deleting sender: $e');
                                          }
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        const PopupMenuItem<String>(
                                          value: 'edit',
                                          child: Text('Edit'),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  )

                                  // SizedBox(
                                  //   height: 4.h,
                                  // )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: categoryProvider
                            .allCategories.data![index1].senders!.length),
                  ],
                );
              },
              itemCount: categoryProvider.allCategories.data!.length);
        }
        if (categoryProvider.allCategories.status == ApiStatus.LOADING) {
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
        return Text(categoryProvider.allCategories.message.toString());
      },
    );
  }
}


