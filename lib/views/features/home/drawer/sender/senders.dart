import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pailmail/core/utils/show_bottom_sheet.dart';
import 'package:pailmail/models/senders/sender_response_model.dart';
import 'package:pailmail/models/senders/senders_1.dart';
import 'package:pailmail/providers/categories_providers/categories_provider.dart';
import 'package:pailmail/providers/sender_provider.dart';
import 'package:pailmail/repositories/sender_repository.dart';
import 'package:pailmail/views/features/inbox_mails/inbox_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/helpers/api_helpers/api_response.dart';
import '../../../../../core/helpers/routers/router.dart';
import '../../../../../core/utils/awesome_dialog.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_auth_button_widget.dart';
import '../../../../widgets/custom_search_bar.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../category/category_screen.dart';
import 'SenderMalisScreen.dart';

class Senders extends StatefulWidget {
  const Senders({Key? key}) : super(key: key);

  @override
  State<Senders> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<Senders> with MyShowBottomSheet,AwesomeDialogMixin {
  // int selindex;
  late TextEditingController senderController;
  String? _selectedCountry;
  bool isInitial = true;

  String? _selectedCategoryName;


  late TextEditingController phoneController;
  late TextEditingController cityController;
  late SenderRepository repository ;
   bool isLoading=false;
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
    int? categoryId=category_id;
    bool hasUserSelectedCategory = false;
    senderController.text=name;
    phoneController.text=senderMobileHint;
    cityController.text=cityName;



    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Column(
            children: [
              CustomAppBar(
                widgetName: "Edit $name",
                onTap: () {
                  Provider.of<CategoriesProvider>(context, listen: false)
                      .setCategoryIndex(categoryIndex: 1);
                  setState(() {
                    selectedCategoryName = '';
                    categoryId=1;
                    hasUserSelectedCategory = false;
                  });
                },
              ),

              // باقي الـ TextFields...
              CustomTextField(
                isSender: true,
                controller: senderController,
                withoutPrefix: false,
                withoutSuffix: true,
                hintText: name,
                customFontSize: 16,
                icon: const Icon(Icons.perm_identity),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sender Name is required';
                  }
                  return null;
                },
              ),
              CustomTextField(
                isSender: true,
                textInputType: TextInputType.number,
                withoutPrefix: false,
                withoutSuffix: true,
                hintText:senderMobileHint,
                customFontSize: 16,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile is required';
                  }
                  return null;
                },
                controller: phoneController,
                icon: const Icon(Icons.phone_android_outlined),
              ),
              CustomTextField(
                isSender: true,
                textInputType: TextInputType.text,
                withoutPrefix: false,
                withoutSuffix: false,
                hintText:_selectedCountry ?? cityName,
                suffixIcon: Icons.arrow_drop_down,
                suffixFunction: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode:
                    true, // يعرض رمز الاتصال الدولي بجانب اسم الدولة
                    onSelect: (Country country) {
                      setState(() {
                        _selectedCountry = country.name??'';

                      });
                    },
                  );
                },
                customFontSize: 16,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile is required';
                  }
                  return null;
                },
                controller: cityController,
                icon: const Icon(Icons.location_city),
              ),


              /// Lower part (Category)
              Padding(
                padding: EdgeInsets.only(
                  top: 16.0.h,
                  bottom: 18.h,
                  left: 11.w,
                  right: 11.w,
                ),
                child: Row(
                  children: [
                    Text("Category",
                        style: buildAppBarTextStyle(
                            color: kBlackColor,
                            letterSpacing: 0.15,
                            fontSizeController: 16)),
                    const Spacer(),
                    Consumer<CategoriesProvider>(
                      builder: (context, categoryProvider, child) {
                        if (categoryProvider.allCategories.status ==
                            ApiStatus.LOADING) {
                          return Text("Other",
                              style: buildAppBarTextStyle(
                                  color: kDarkGreyColor,
                                  letterSpacing: 0.15,
                                  fontSizeController: 14));
                        } else if (categoryProvider.allCategories.status ==
                            ApiStatus.COMPLETED) {
                          var categoryIndex =
                              categoryProvider.categoryPosition;
                          final newCategory =
                          categoryProvider.allCategories.data?[categoryIndex];

                          if (hasUserSelectedCategory) {
                            selectedCategoryName =
                                newCategory?.name ?? selectedCategoryName;
                            categoryId=categoryIndex;
                          }

                          return Text(selectedCategoryName,
                              style: buildAppBarTextStyle(
                                  color: kDarkGreyColor,
                                  letterSpacing: 0.15,
                                  fontSizeController: 14));
                        } else {
                          return Text(categoryProvider.allCategories.message ?? '');
                        }
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          hasUserSelectedCategory = true;
                        });
                        showSheet(context, const CategoryScreen());
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: kDarkGreyColor,
                        size: 16,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 12.h,),

             isLoading ==true? CustomAuthButtonWidget(
                child: progressSpinkit,
                onTap: () {
                  // Action here
                 try{

                  SenderRepository().updateSender(senderController.text, phoneController.text, _selectedCountry,categoryId, sender_id);
                  buildSuccessDialog(context, 'update ${senderController.text} info', "Success Update !");
                  Provider.of<CategoriesProvider>(context,
                      listen: false)
                      .fetchAllCategories();

                  Navigator.pop(context);
                 }catch  (err){
                   buildFailedDialog(context, 'Ops , Cannot Update ${senderController.text} info ! try again!',() => NavigationRoutes().pop(context),);
                   setState(() {
                     isLoading=false;
                   });
                   print(err);
                 }

                },
              ):CustomAuthButtonWidget(
               child: const Text("Update Sender!",style: TextStyle(color: kWhiteColor),),
               onTap: () {
                 // Action here

                 setState(() {
                 isLoading=true;
                 });



               },
             )
            ],
          );
        },
      ),
    );
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
                selectedCategoryId=category.id;
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
                                        mailsList: mails, sender: category.senders![indexSender],
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [

                                  Transform.scale(
                                    scale:
                                        1.5, // Adjust the scale factor as needed
                                    child: Container(
                                      margin:
                                          EdgeInsetsDirectional.only(end: 8.h),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kDarkGreyColor,
                                      ),
                                      child:  Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 20.r,
                                      ),
                                    ),

                                  ),
                                  SizedBox(width: 8.w,),
                                  Text(
                                    category.senders![indexSender].name
                                        .toString(),
                                    style: buildAppBarTextStyle(
                                        fontSizeController: 14,
                                        color: kBlackColor),
                                  ),

                                    ],
                                  )
                                  , Padding(
                                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                                    child: PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert_outlined),
                                      onSelected: (value) async {
                                        if (value == 'edit') {
                                          _selectedCountry=category.senders![indexSender].address??'';
                                          _selectedCategoryName=category.name ?? '';
                                          showSheet(context, _editSender(name :category.senders![indexSender].name!, senderMobileHint:category.senders![indexSender].mobile!, cityName:category.senders![indexSender].address ??'', categoryName: category.name ?? '', category_id: category.id!,sender_id: category.senders![indexSender].id! , ),height: .80);
                                        } else if (value == 'delete') {

                                            try {
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
                                                    await repository.deleteSender(category.senders![indexSender].id!);

                                                    final successDialog = AwesomeDialog(
                                                      context: context,
                                                      dialogType: DialogType.success,
                                                      animType: AnimType.topSlide,
                                                      title: 'Deleted',
                                                      desc: 'Sender was deleted successfully!',
                                                      autoHide: const Duration(seconds: 2),
                                                      onDismissCallback: (type) {

                                                        Provider.of<CategoriesProvider>(context,
                                                            listen: false)
                                                            .fetchAllCategories();
                                                      },
                                                    );

                                                    successDialog.show();
                                                  } catch (e) {
                                                    print('Error deleting sender: $e');
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

// import 'package:pailmail/providers/categories_provider.dart';
// import 'package:pailmail/providers/sender_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../core/helpers/api_helpers/api_response.dart';
// import '../../../../../core/utils/constants.dart';
// import '../../../../../models/categories/category_response_model.dart';
// import '../../../../../models/senders/senders_1.dart';
// import '../../../../../repositories/sender_repository.dart';
// import '../../../../widgets/custom_app_bar.dart';
// import '../../../../widgets/custom_search_bar.dart';
//
// class Senders extends StatefulWidget {
//   const Senders({super.key});
//
//   @override
//   State<Senders> createState() => _SendersState();
// }
//
// class _SendersState extends State<Senders> {
//   SenderRepository? sn;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: kBackgroundColor,
//         body: Padding(
//             padding: EdgeInsetsDirectional.only(
//                 top: 20.0.h, start: 20.w, bottom: 62.h),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               CustomAppBar(
//                 widgetName: 'Sender',
//                 endPadding: 27.w,
//                 bottomPadding: 15.h,
//               ),
//
//               ///Search Bar
//               Padding(
//                 padding: EdgeInsetsDirectional.only(end: 12.w),
//                 child: const CustomSearchBar(),
//               ),
//
//               SingleChildScrollView(
//                 physics: AlwaysScrollableScrollPhysics(),
//                 child: Consumer<CategoriesProvider>(
//                     builder: (_, categoryProvider, __) {
//                   if (categoryProvider.allCategories.status ==
//                       ApiStatus.LOADING) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (categoryProvider.allCategories.status ==
//                       ApiStatus.ERROR) {
//                     return Center(
//                       child: Text('${categoryProvider.allCategories.message}'),
//                     );
//                   }
//                   //CategoryElement send = categoryProvider.allCategories.data![index];
//                   return ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       CategoryElement categoryName =
//                           categoryProvider.allCategories.data![index];
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ///Company Name
//                           ///هيتغير لما يجي من ال api
//                           Padding(
//                             padding: EdgeInsets.only(top: 23.0, bottom: 4.h),
//                             child: Text(
//                               categoryName.name.toString(),
//                               style: buildAppBarTextStyle(
//                                   fontSizeController: 12,
//                                   color: const Color(0xffafafaf)),
//                             ),
//                           ),
//
//                           ///هيتغير اسم السيندر لما يجي من ال api
//                           ///sender convert it to future builder
//                           ListView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               padding: EdgeInsets.zero,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 // CategoryElement categorySender=categoryProvider.allCategories.data![index];
//                                 return Container(
//                                   padding: EdgeInsetsDirectional.symmetric(
//                                       vertical: 20.h),
//                                   decoration: buildBoxDecoration(),
//                                   child: InkWell(
//                                     onTap: () {
//                                       String id = categoryName
//                                           .senders![index].id
//                                           .toString();
//                                       sn = SenderRepository().deleteSender(id)
//                                           as SenderRepository?;
//                                     },
//                                     child: Row(
//                                       children: [
//                                         Transform.scale(
//                                           scale: 1.5,
//                                           // Adjust the scale factor as needed
//                                           child: Container(
//                                             margin: EdgeInsetsDirectional.only(
//                                                 end: 8.h),
//                                             decoration: const BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: kDarkGreyColor,
//                                             ),
//                                             child: const Icon(
//                                               Icons.person,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                         Text(
//                                           categoryName.senders![index].name
//                                               .toString(),
//                                           style: buildAppBarTextStyle(
//                                               fontSizeController: 14,
//                                               color: kBlackColor),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               //categoryName.senders!.length
//                               itemCount: 5),
//                         ],
//                       );
//                     },
//                     itemCount: categoryProvider.allCategories.data!.length,
//                   );
//                 }),
//               ),
//             ])));
//   }
// }
//return
//                                         Provider.of<SenderProvider>(
//                                               context,
//                                               listen: false)
//                                           .getMailsOfSenderList(
//                                               id: category
//                                                   .senders![indexSender].id
//                                                   .toString())
//                                           .then(
//                                         (value) {
//                                           var sender =
//                                               Provider.of<SenderProvider>(
//                                                       context,
//                                                       listen: false)
//                                                   .mailOfSenderList;
//
//                                           //  print("**************$mails");
//                                           if (sender.status ==
//                                               ApiStatus.COMPLETED) {
//                                             var mails = sender.data!;
//
//                                             return SenderMailsScreen(
//                                               mailsList: mails,
//                                             );
//                                           }
//                                         },
//                                       );
