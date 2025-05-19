import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:pailmail/core/utils/show_date_converter.dart';
import 'package:pailmail/models/mails/mail.dart';
import 'package:pailmail/models/senders/sender.dart';
import 'package:pailmail/providers/auth_provider.dart';
import 'package:pailmail/providers/categories_providers/categories_provider.dart';
import 'package:pailmail/providers/status_provider.dart';

import 'package:pailmail/repositories/mails_reprository.dart';

import 'package:pailmail/providers/tag_provider.dart';
import 'package:pailmail/repositories/sender_repository.dart';
import 'package:pailmail/views/features/status/status_screen.dart';
import 'package:pailmail/views/features/tags/tags_screen.dart';
import 'package:pailmail/views/widgets/custom_app_bar.dart';
import 'package:pailmail/views/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/show_bottom_sheet.dart';
import '../../../core/utils/snckbar.dart';

import '../../../models/senders/senderMails.dart';

import '../../../providers/attachment_provider.dart';
import '../../../providers/categories_providers/category_mail_provider.dart';
import '../../../storage/shared_prefs.dart';

import '../../widgets/custom_app_bar_with_icon.dart';
import '../../widgets/custom_chip.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_container_details.dart';
import '../../widgets/custom_date_container.dart';
import '../../widgets/custom_expansion_tile.dart';
import '../../widgets/custom_profile_photo_container.dart';
import '../../widgets/custom_text_field.dart';
import '../category/category_screen.dart';
import '../senders/sender_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen(
      {required this.isDetails, super.key, this.mail, this.mails, this.IsSender,  this.sender});
  final bool isDetails;
  final Mail? mail;
  final Mails? mails;
  final Sender? sender;
  final bool? IsSender;

  //final Future<List<Mails>?>? mails;

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with MyShowBottomSheet, ShowSnackBar ,DateConverter{
  bool isDisable = false;

  final DateTime _selectedDate = DateTime.now();
  late List<Map<String, dynamic>> addActivity;
  late TextEditingController senderController;
  late TextEditingController addNewActivityController;
  late TextEditingController addDecisionController;
  late TextEditingController phoneController;
  late TextEditingController archiveController;
  late TextEditingController tileOfMailController;
  late TextEditingController dateController;
  late TextEditingController descriptionController;
  late SenderRepository sender;
  String? saveCate = '';
  int? saveCateId = 1;
  String? saveStatusName = 'Inbox';
  String? saveStatusId = '1';
  Color? saveStatusColor = const Color(0xffFA3A57);
  int? sender_id;
  int? mail_id;

  int indexOfCat(String mail) {
    switch (mail) {
      case "1":
        return 3;
      case "2":
        return 0;
      case "3":
        return 1;
      case "4":
        return 2;
      default:
        return 0;
    }
  }

  String fetchOrgName(int index) {
    switch (index) {
      case 0:
        return "official Organizations";
      case 1:
        return "ngos";
      case 2:
        return "foreign";
      case 3:
        return "other";
      default:
        return "";
    }
  }

  late AttachmentProvider attachmentProvider;
  late CategoriesProvider categoriesProvider;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    addActivity = [];
    addNewActivityController = TextEditingController();
    senderController = TextEditingController();
    addDecisionController = TextEditingController();
    archiveController = TextEditingController();
    dateController = TextEditingController();
    tileOfMailController = TextEditingController();
    phoneController = TextEditingController();
    descriptionController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      attachmentProvider = Provider.of<AttachmentProvider>(context, listen: false);
      categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);
    });


  }

  bool _customTileExpanded = false;
  List<int>? listTag = [];

  void expandCollapse() {
    setState(() {
      _customTileExpanded = !_customTileExpanded;
    });
  }

  clear() {
    senderController.clear();
    phoneController.clear();

    Provider.of<CategoriesProvider>(context, listen: false)
        .setSenderIndex(selectedIndex: -1);
    Provider.of<CategoriesProvider>(context, listen: false)
        .setCategoryIndex(categoryIndex: 1);

    Provider.of<StatusProvider>(context, listen: false).changeStatus(
      selectedIndex: -1,
    );

    setState(() {
      isDisable = false;
      senderIndex = -1;
    });
  }

  // Future<void> storeImage() async {
  //   for (int i = 0; i < pickedMultiImage.length; i++) {
  //     await UploadImage().uploadImage(File(pickedMultiImage[i]!.path), mail_id);
  //   }
  // }

  // late String nameSender =
  //     Provider.of<CategoriesProvider>(context, listen: false)
  //         .allCategories
  //         .data![Provider.of<CategoriesProvider>(context, listen: false)
  //             .categoryPosition]
  //         .senders![Provider.of<CategoriesProvider>(context, listen: false)
  //             .senderPosition]
  //         .name
  //         .toString();
  late String categoryId =
      Provider.of<CategoriesProvider>(context, listen: false)
          .allCategories
          .data![Provider.of<CategoriesProvider>(context, listen: false)
              .categoryPosition]
          .id!
          .toString();
  // late String mobileSender =
  //     Provider.of<CategoriesProvider>(context, listen: false)
  //         .allCategories
  //         .data![
  //             Provider.of<CategoriesProvider>(context, listen: false)
  //                 .categoryPosition]
  //         .senders![Provider.of<CategoriesProvider>(context, listen: false)
  //             .senderPosition]
  //         .mobile
  //         .toString();
  dynamic senderIndex = -1;

  getSender() {
    final provider =context.read<CategoriesProvider>();




    final sender = provider.selectedSender;

    print("Sender name: ${sender?.name}");

    senderController.text = sender?.name ?? "";
    phoneController.text = sender?.mobile ?? "";
    senderIndex = sender?.id?.toString() ?? "";
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //TODO: Modify icons
    //TODO: Handle add image padding /margin
    return Scaffold(
        body: Padding(
      padding:
          EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.h, bottom: 16.h),
      child: Form(
        key: _formKey,
        child: Column(children: [
          ///App Bar
          widget.isDetails
              // widget.mail!.id.toString(),
              ? CustomAppBarWithIcon(
                  widgetName: "Details",
                  left_icon: Icons.arrow_back_ios_new,
                  right_icon: Icons.more_horiz,
                  id: widget.IsSender!
                      ? widget.sender!.id
                      : widget.sender!.id)
        //             : const CustomAppBar(widgetName: "New Inbox", bottomPadding: 16),

        //                 right_icon: Icons.menu,

              : CustomAppBar(
                  widgetName: "New Inbox",
                  bottomPadding: 16,
                  isEdit: true,
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  // خذ كل الـ Providers قبل أي async
                  // final attachmentProvider = Provider.of<AttachmentProvider>(context, listen: false);
                  // final categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);

                  if (senderIndex == -1) {

                      SenderRepository()
                          .createSender(
                          name: senderController.text,
                          mobile: phoneController.text,
                          categoryId: categoryId)
                          .then((value) {
                        showSnackBar(context, message: "Created New Sender!", duration: 1);

                        // categoriesProvider.fetchAllCategories(); // استخدم المحفوظ مسبقاً

                        sender_id = value!.last.id;

                        Future.delayed(const Duration(milliseconds: 500), () async {
                          await MailsRepository()
                              .createMail(
                              subject: tileOfMailController.text,
                              description: descriptionController.text,
                              sender_id: sender_id.toString(),
                              archive_number: archiveController.text,
                              archive_date: DateTime.now(),
                              status_id: saveStatusId.toString(),
                              tags: listTag,
                              activities: addActivity)
                              .then((value) async {
                            mail_id = value?.id;

                            if (context.mounted && pickedImage != null) {
                              await attachmentProvider.uploadAttachment(
                                  pickedImage, mail_id.toString(), tileOfMailController.text);
                            }

                            if (context.mounted) {
                              Navigator.pop(context, 'refresh');

                              showSnackBar(context, message: "Created Mail", duration: 2);
                              // refresh();
                              clear();
                            }
                          }).catchError((err) {
                            if (context.mounted) {
                              showSnackBar(context,
                                  message: "Failed to create mail", error: true, duration: 1);
                            }
                          });

                      }).catchError((err) {
                        if (context.mounted) {
                          if (err.toString() == 'The mobile has already been taken') {
                            showSnackBar(context,
                                message: 'The mobile has already been taken',
                                error: true,
                                duration: 2);
                          } else {
                            showSnackBar(context, message: err.toString(), error: true, duration: 2);
                          }
                        }
                      });
                    });
                  } else {
                      await MailsRepository()
                          .createMail(
                          subject: tileOfMailController.text,
                          description: descriptionController.text,
                          sender_id: senderIndex.toString(),
                          archive_number: archiveController.text,
                          archive_date: DateTime.now(),
                          status_id: saveStatusId.toString(),
                          tags: listTag,
                          activities: addActivity)
                          .then((value) async {
                        mail_id = value?.id;

                        if (context.mounted && pickedImage != null) {
                          await attachmentProvider.uploadAttachment(
                              pickedImage, mail_id.toString(), tileOfMailController.text);
                        }

                        if (context.mounted) {
                          Navigator.pop(context, 'refresh');
                          showSnackBar(
                              context, message: "Mail Created!", duration: 2);
                          // refresh();
                          clear();
                        }
                      }).catchError((err) {
                        if (context.mounted) {
                          print(err.toString());
                          // showSnackBar(context,
                          //     message: 'Failed to create mail!', error: true, duration: 1);
                        }
                      });

                  }
                }
              }

          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              // physics: const AlwaysScrollableScrollPhysics(),
              children: [
                ///Big Container
                widget.isDetails
                    ? CustomContainerDetails(
                        organizationName: widget.IsSender!
                            ? widget.mails?.sender?.name ?? ""
                            : widget.sender?.name ?? "",
                        organizationCategory: widget.IsSender!
                            ? widget.mails!.sender!.category!.name ?? ""
                            : fetchOrgName(indexOfCat((widget.mail?.sender?.categoryId ?? '1'))) ,
                        dateOrgName: widget.IsSender!
                            ? formatDate(widget.mails!.archiveDate?? "")
                            : formatDate(widget.mail!.archiveDate ?? ""),
                        dateOrgCategory: widget.IsSender!
                            ? widget.mails!.archiveNumber ?? ""
                            : widget.mail!.archiveNumber ?? "",
                        subject: ExpansionTile(
                          shape: const Border(),
                          initiallyExpanded: false,
                          onExpansionChanged: (bool expanded) async {
                            expandCollapse();
                          },
                          trailing: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              _customTileExpanded
                                  ? Icons.keyboard_arrow_down_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              size: _customTileExpanded ? 30 : 20,
                              color: _customTileExpanded
                                  ? kDarkGreyColor
                                  : kMediumGreyColor,
                              // weight: 12,
                            ),
                          ),
                          title: Text(
                            widget.IsSender!
                                ? widget.mails!.subject ?? ""
                                : widget.mail!.subject ?? "",
                            style:
                                tileTextTitleStyle.copyWith(color: kBlackColor),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 18.h),
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  widget.IsSender!
                                      ? widget.mails!.description ?? ""
                                      : widget.mail!.description ?? "",
                                ),
                              ),
                            )
                          ],
                        ),
                        onPress: () {})
                    : CustomContainer(
                        childContainer: Column(
                        children: [
                          ///Upper Part(Name)
                          CustomTextField(
                              isDisable: isDisable,
                              isSender: true,
                              controller: senderController,
                              withoutPrefix: false,
                              withoutSuffix: false,
                              hintText: context.watch<CategoriesProvider>().senderNameHint,
                              customFontSize: 16,
                              icon: const Icon(Icons.perm_identity),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Sender Name is required';
                                }
                                return null;
                              },
                            suffixFunction: () async {
                              final result = await showSheet(context, const SenderScreen());

                              if (result == true) {
                                setState(() {
                                  isDisable = result;
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    final provider = Provider.of<CategoriesProvider>(context, listen: false);
                                    print("🚨 Real category list length: ${provider.allCategories.data?.length}");
                                    print("🚨 Selected category index: ${provider.categoryPosition}");
                                    getSender();
                                  });
                                });
                              }
                            })
,
                          CustomTextField(
                            isDisable: isDisable,
                            isSender: true,
                            textInputType: TextInputType.number,
                            withoutPrefix: false,
                            hintText:context.watch<CategoriesProvider>().senderMobileHint,
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


                          ///Lower part (category)
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16.0.h,
                                bottom: 18.h,
                                left: 11.w,
                                right: 11.w),
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
                                    } else if (categoryProvider
                                            .allCategories.status ==
                                        ApiStatus.COMPLETED) {
                                      // final category = categoryProvider
                                      //         .allCategories.data?[
                                      //    context.watch<CategoriesProvider>()
                                      //         .categoryPosition];
                                      // print("category position ${context.watch<CategoriesProvider>()
                                      //     .categoryPosition}");
                                      // print("Sender Index:  ${context.watch<CategoriesProvider>()
                                      //     .senderPosition}");
                                      // print("Senders Length: ${context.watch<CategoriesProvider>()
                                      //     .allCategories.data?[context.watch<CategoriesProvider>()
                                      //     .categoryPosition].senders?.length}");
                                     final categoryIndex= context.watch<CategoriesProvider>().categoryPosition;
                                     final singleCategory=categoryProvider.allCategories.data?[categoryIndex];
                                      // final categoryName =
                                      //     category?.name?? 'Other';
                                      // saveCate = categoryName.toString();
                                      // saveCateId = category?.id;

                                      print("ttttttttttttttt  ${singleCategory?.name}");
                                      return Text(singleCategory?.name??'other',
                                          style: buildAppBarTextStyle(
                                              color: kDarkGreyColor,
                                              letterSpacing: 0.15,
                                              fontSizeController: 14));
                                    } else {
                                      return Text(categoryProvider
                                          .allCategories.message
                                          .toString());
                                    }
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
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
                        ],
                      )),
                widget.isDetails
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: 15.h,
                      ),

                ///Title of mail and description
                widget.isDetails
                    ? const SizedBox.shrink()
                    : CustomContainer(
                        childContainer: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            hintText: 'Title of mail',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Title of mail is required!';
                              }
                              return null;
                            },
                            customFontSize: 20,
                            withoutPrefix: true,
                            controller: tileOfMailController,
                          ),
                          const CustomDivider(),
                          CustomTextField(
                            hintText: 'Description',
                            customFontSize: 14,
                            textInputType: TextInputType.multiline,
                            // للسماح بإدخال أكثر من سطر
                            maxLine: null,
                            controller: descriptionController,
                          ),
                        ],
                      )),
                widget.isDetails
                    ? SizedBox()
                    : SizedBox(
                        height: 29.h,
                      ),

                ///date calender
                widget.isDetails
                    ? const SizedBox.shrink()
                    : CustomContainer(
                        childContainer: Column(children: [
                        CustomDateContainer(
                            title: 'Date',
                            isFilterScreen: false,
                            selectedDate: _selectedDate),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 0.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.archive_outlined,
                                color: kDarkGreyColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Expanded(
                                // توسيع الحقل ليحتل العرض المتاح
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Archive Number",
                                      style: buildAppBarTextStyle(
                                          color: kBlackColor,
                                          letterSpacing: 0.15,
                                          fontSizeController: 16),
                                    ),

                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: CustomTextField(
                                        withoutPrefix: true,
                                        paddingHor: 0,
                                        hintText: '2021/2022',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Archive number is required !';
                                          }
                                          return null;
                                        },
                                        maxLine: null,
                                        customFontSize: 16.0,
                                        controller: archiveController,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
                SizedBox(
                  height: 19.h,
                ),

                ///Tags it will open bottom Sheet

                !widget.isDetails
                    ? buildListTile(
                        onTap: () {
                          Provider.of<TagProvider>(context, listen: false)
                              .getTagList();


                         final result=showSheet(context, const TagsScreen(
                                navFromHome: false,
                              ));

                         listTag=result;
                            print("//////////////////////////${listTag!.length}");
                            },

                        icon: Icons.tag_rounded,
                        widget: Text(
                          "Tags",
                          style: buildAppBarTextStyle(
                              color: const Color(0xff272727),
                              letterSpacing: 0.15,
                              fontSizeController: 16.sp),
                        ),
                      )
                    : buildListTile(
                  onTap: () async {
                    final result = await showSheet(
                      context,
                      TagsScreen(
                        tags: widget.mail?.tags ?? [],
                        navFromHome: false,
                        mailDetails: true,
                      ),
                    );

                    listTag = result;
                    print("//////////////////////////${listTag?.length}");
                  }
,                        icon: Icons.tag_rounded,
                  widget:Text("data"),
//                         widget: CustomExpansionTile(
//                           widgetOfTile: Text("Tags",style:buildAppBarTextStyle(
//                               color: const Color(0xff272727),
//                               letterSpacing: 0.15,
//                               fontSizeController: 16.sp),
//                           ),
//                           children: [
//                             Consumer<TagProvider>(
//                               builder: (context, value, child) {
//                                 if (value.tagList.status == ApiStatus.LOADING ||
//                                     value.tagList.status == ApiStatus.ERROR) {
//                                   return SizedBox.shrink();
//                                 } else {
//                                   if (value.tagList.data!.isEmpty) {
//                                     return SizedBox.shrink();
//                                   } else {
//                                     var tags = value.tagList.data!;
//                                     return Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsetsDirectional.symmetric(
//                                               horizontal: 20.w),
//                                           child: Text(
//                                             "tags".tr(),
//                                             style: tileTextTitleStyle,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 14.h,
//                                         ),
//                                         Container(
//                                           width: double.infinity,
//                                           padding:
//                                           const EdgeInsetsDirectional.symmetric(
//                                               horizontal: 12, vertical: 12),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.circular(
//                                               30,
//                                             ),
//                                           ),
//                                           child: Wrap(
//                                             //TODO:Hnadle move to tag screen
//                                             spacing: 6,
//                                             children: [
//                                               CustomChip(
//                                                 isHomeTag: true,
//                                                 text: "allTags".tr(),
//                                                 onPressed: () {
//                                                   Provider.of<TagProvider>(context,
//                                                       listen: false)
//                                                       .getTagWithMailList("all");
//                                                   // var tag =
//                                                   //     Provider.of<TagProvider>(
//                                                   //             context,
//                                                   //             listen: true)
//                                                   //         .tagWithMailList;
//                                                   // print("${tag.status}");
//                                                   Navigator.push(context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) {
//                                                           return TagsScreen(
//                                                             selectedTag: -1,
//                                                             tags: tags,
//                                                             navFromHome: true,
//                                                           );
//                                                         },
//                                                       ));
//                                                 },
//                                               ),
//                                               for (int i = 0;
//                                               i < listTag?.length;
//                                               i++) ...{
//                                                 CustomChip(
//                                                     text: "${listTag?[i].name}",
//                                                     isHomeTag: true,
//                                                     onPressed: () {
//                                                       Provider.of<TagProvider>(
//                                                           context,
//                                                           listen: false)
//                                                           .getTagWithMailList(
//                                                           "[${tags[i].id}]");
//                                                       Navigator.push(context,
//                                                           MaterialPageRoute(
//                                                             builder: (context) {
//                                                               return TagsScreen(
//                                                                 selectedTag: tags[i].id,
//                                                                 tags: tags,
//                                                                 navFromHome: true,
//                                                               );
//                                                             },
//                                                           ));
//                                                     }),
//                                               }
//                                             ],
//                                           ),
// //                                     ]);
// //                               } else {
// //                                 var data = value.mailsCategory[3].data;
// //                                 return CustomExpansionTile(
// //                                   index: 3,
// //                                   widgetOfTile: Text(
// //                                     "other".tr(),
// //                                     style: tileTextTitleStyle,
// //                                   ),
// //                                   mailNumber: data!.length.toString(),
// //                                   children: [
// //                                     ListView.builder(
// //                                       itemBuilder: (context, index) {
// //                                         return CustomMailContainer(
// //                                           onTap: () {
// //                                             Navigator.push(context,
// //                                                 MaterialPageRoute(
// //                                               builder: (context) {
// //                                                 return InboxScreen(
// //                                                   isDetails: true,
// //                                                   mail: data[index],
// //                                                   IsSender: false,
// //                                                 );
// //                                               },
// //                                             ));
// //                                           },
// //                                           organizationName:
// //                                               data[index].sender!.name ?? "",
// //                                           color: hexToColor(
// //                                               data[index].status!.color ?? ''),
// //                                           date: data[index].archiveDate ?? "",
// //                                           description:
// //                                               data[index].description ?? "",
// //                                           images: const [], //TODO:display Images
// //                                           tags: data[index].tags ?? [],
// //                                           subject: data[index].subject ?? "",
// //                                           endMargin: 8,
// //                                         );
// //                                       },
// //                                       itemCount:
// //                                           data.length < 3 ? data.length : 3,
// //                                       shrinkWrap: true,
// //                                     ),
// //                                     const SizedBox(
// //                                       height: 8,
//                                         ),
//                                       ],
//                                     );
//                                   }
//                                 }
//                               },
//                             ),
//
//                           ], ),

                      ),

                SizedBox(
                  height: 12.h,
                ),

                /// Categories it will view categories screen
                buildListTile(
                  icon: Icons.forward_to_inbox,
                  onTap: SharedPreferencesController().roleName == 'user'
                      ? () {}
                      : () {
                          showSheet(context, const StatusScreen());
                        },
                  widget: Row(
                    children: [
                      widget.isDetails
                          ? CustomContainer(
                              isInBox: true,
                              backgroundColor: Color(int.parse(widget.IsSender!
                                  ? widget.mails!.status!.color.toString()
                                  : widget.mail!.status!.color.toString())),
                              childContainer: Text(
                                widget.IsSender!
                                    ? widget.mails!.status!.name ?? 'inbox'
                                    : widget.mail!.status!.name ?? 'inbox',
                                style: const TextStyle(color: Colors.white),
                              ))
                          : Consumer<StatusProvider>(builder:
                              (BuildContext context,
                                  StatusProvider statusProvider, Widget? child) {
                              if (statusProvider.allStatus.status ==
                                      ApiStatus.LOADING ||
                                  Provider.of<StatusProvider>(context,
                                              listen: false)
                                          .selectedIndex <
                                      0) // to avoid null when status filter is cleared
                              {
                                return const CustomContainer(
                                    isInBox: true,
                                    backgroundColor: Color(0xffFA3A57),
                                    childContainer: Text(
                                      "Inbox",
                                      style: TextStyle(color: Colors.white),
                                    ));
                              } else if (statusProvider.allStatus.status ==
                                  ApiStatus.COMPLETED) {
                                final status = statusProvider.allStatus.data![
                                    Provider.of<StatusProvider>(context,
                                            listen: false)
                                        .selectedIndex];
                                //indexSelected  like variable .....
                                saveStatusColor =
                                    Color(int.parse(status.color.toString()));
                                saveStatusName = status.name.toString();
                                saveStatusId = status.id.toString();
                                print("hhhhhhhhhh $saveStatusColor");

                                return CustomContainer(
                                    isInBox: true,
                                    backgroundColor:
                                        Color(int.parse(status.color.toString())),
                                    childContainer: Text(
                                      status.name.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ));
                              } else {
                                return Text(
                                    statusProvider.allStatus.message.toString());
                              }
                            }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),

                ///Add description
                CustomContainer(
                    childContainer: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Decision",
                        style: buildAppBarTextStyle(
                            color: kBlackColor, letterSpacing: 0.15),
                      ),
                      widget.isDetails
                          ? Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(widget.IsSender!
                                  ? widget.mails?.decision ?? "There is no decision yet!"
                                  :(widget.mails?.decision?.isNotEmpty ?? false)
                                  ? widget.mails!.decision!
                                  : "There is no decision yet!"))
                          : CustomTextField(
                              paddingHor: 0,
                              hintText: "Add Decision…",
                              customFontSize: 14,
                              controller: addDecisionController),
                    ],
                  ),
                )),
                SizedBox(
                  height: 16.h,
                ),

                ///Pick Image
                CustomContainer(
                    childContainer: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    _pickedImage;
                                  },
                                  child: Text(
                                    "Add Image",
                                    style: buildAppBarTextStyle(
                                        fontSizeController: 16.sp,
                                        letterSpacing: 0.15),
                                  ),
                                ),
                                pickedImage ==null
                                    ? const SizedBox.shrink()
                                    : InkWell(
                                        onTap: () {
                                          pickedImage=null;
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Clear All",
                                          style: buildAppBarTextStyle(
                                              fontSizeController: 16.sp,
                                              letterSpacing: 0.15),
                                        ),
                                      ),
                              ],
                            ),

                            ///view Images
                            widget.isDetails
                                ? widget.mail!.attachments!.isNotEmpty?CustomProfilePhotoContainer(
                                    image:
                                        '$imageUrl/${widget.mail!.attachments}',
                                    raduis: 50,
                                  )
                                : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("No images yet!"),
                                  ],
                                ):pickedImage ==null
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        height: 16.h,
                                      ),


                                 pickedImage!=null ? viewImages() :SizedBox.shrink()


                          ],
                        )
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
                  child: CustomExpansionTile(
                      mailNumber:
                          addActivity.isNotEmpty ? "${addActivity.length}" : "",
                      widgetOfTile: Text(
                        "Activity",
                        style: buildAppBarTextStyle(
                            letterSpacing: 0.15,
                            fontSizeController: 20.sp,
                            color: kBlackColor),
                      ),
                      isIndexWidet: false,
                      children: [
                        widget.isDetails
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: widget.mail!.activities!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0.h),
                                      child: CustomContainer(
                                        childContainer: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Provider.of<AuthProvider>(context)
                                                          .currentUser
                                                          .data
                                                          ?.user
                                                          .image ==
                                                      null
                                                  ? const Icon(
                                                      Icons.account_circle,
                                                      size: 90,
                                                      color: kLightGreyColor,
                                                    )
                                                  : CustomProfilePhotoContainer(
                                                      image:
                                                          '$imageUrl/${Provider.of<AuthProvider>(context).currentUser.data?.user.image}',
                                                      raduis: 50.r,
                                                    ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Column(
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${Provider.of<AuthProvider>(context).currentUser.data?.user.name}"),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Text(widget.mail!
                                                      .activities![index].body
                                                      .toString()),
                                                ],
                                              ),
                                               const Spacer(),
                                              Text(
                                                  formatDate(widget.mail!.activities![index].createdAt.toString())
                                                      .split(" ")[0])
                                            ],
                                          ),
                                        ),
                                      ));
                                })
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: addActivity.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0.h),
                                      child: CustomContainer(
                                        childContainer: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Provider.of<AuthProvider>(context)
                                                          .currentUser
                                                          .data
                                                          ?.user
                                                          .image ==
                                                      null
                                                  ? const Icon(
                                                      Icons.account_circle,
                                                      size: 90,
                                                      color: kLightGreyColor,
                                                    )
                                                  : CustomProfilePhotoContainer(
                                                      image:
                                                          '$imageUrl/${Provider.of<AuthProvider>(context).currentUser.data?.user.image}',
                                                      raduis: 50.r,
                                                    ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(addActivity[index]
                                                          ['user_name']),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Text(addActivity[index]
                                                          ['body']),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                })
                      ]),
                ),

                SizedBox(
                  height: 10.h,
                ),

                SharedPreferencesController().roleName == 'user'
                    ? SizedBox.expand()
                    : CustomContainer(
                        isInBox: true,
                        backgroundColor: kLightGreyColor,
                        childContainer: CustomTextField(
                            isAddActivity: true,
                            suffixIcon: Icons.send_outlined,
                            withoutPrefix: false,
                            suffixFunction: () {
                              print("sss");
                              print("${addNewActivityController.text} rrr");
                              if (addNewActivityController.text.isNotEmpty) {
                                setState(() {
                                  Map<String, dynamic> newActivity =
                                      <String, String>{
                                    "body": addNewActivityController.text,
                                    "user_name": Provider.of<AuthProvider>(
                                            context,
                                            listen: false)
                                        .currentUser
                                        .data!
                                        .user
                                        .name
                                        .toString(),
                                        "user_id": Provider.of<AuthProvider>(
                                            context,
                                            listen: false)
                                            .currentUser
                                            .data!
                                            .user
                                            .id
                                            .toString()
                                  };
                                  setState(() {
                                    addActivity.add(newActivity);
                                  });
                                });
                                addNewActivityController.clear();
                              }
                            },
                            withoutSuffix: false,
                            maxLine: null,
                            icon: Provider.of<AuthProvider>(context)
                                        .currentUser
                                        .data
                                        ?.user
                                        .image ==
                                    null
                                ? const Icon(Icons.account_circle_outlined)
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0.w),
                                    child: CustomProfilePhotoContainer(
                                      image:
                                          '$imageUrl/${Provider.of<AuthProvider>(context, listen: false).currentUser.data?.user.image}',
                                      raduis: 40.r,
                                    ),
                                  ),
                            hintText: "Add new Activity ...",
                            customFontSize: 14.sp,
                            controller: addNewActivityController),
                      ),
              ],
            ),
          ),
        ]),
      ),
    ));
  }

   viewImages() {
    return Stack(
      // fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
              shape: BoxShape.rectangle),
          child: pickedImage != null
              ? Image.file(
                     pickedImage!,
                  fit: BoxFit.cover,
                )
              : const SizedBox.shrink(),
        ),

        ///Delete of all images

        PositionedDirectional(
          start: -10,
          top: -10,
          child: InkWell(
            onTap: () {
              setState(() {});
              pickedImage=null;
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.shade100,
              child: const Icon(
                Icons.delete,
                size: 20,
                color: kRedColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  CustomContainer buildListTile(
      {required IconData icon, required Widget widget, Function()? onTap}) {
    return CustomContainer(
      childContainer: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 18.0),
          child: Icon(
            icon,
            size: 20,
            color: kDarkGreyColor,
          ),
        ),
        title: widget,
        trailing: Padding(
          padding: const EdgeInsetsDirectional.only(end: 17.0),
          child: GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.arrow_forward_ios,
              color: kMediumGreyColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  // void get _showImageSourceOptions {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(15), topRight: Radius.circular(15))),
  //     builder: (context) {
  //       return SafeArea(
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.h),
  //           child: Column(
  //             children: [
  //               const CustomAppBar(widgetName: "Add Image"),
  //               Center(
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     InkWell(
  //                         onTap: () async {
  //                           await _pickMultiImage;
  //                         },
  //                         child: ImagesContainers(
  //                             color: kLightGreyColor,
  //                             icon: Icons.camera,
  //                             fontColor: kDarkGreyColor,
  //                             iconColor: kDarkGreyColor,
  //                             text: 'Gallery')),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Container ImagesContainers(
      {required Color color,
      required IconData icon,
      required String text,
      Color fontColor = Colors.white,
      required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: color,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            text,
            style: TextStyle(color: fontColor),
          ),
        ],
      ),
    );
  }

  File? pickedImage;
  ImagePicker imagePick = ImagePicker();

  Future<File?> get _pickedImage async {
    XFile? image = await imagePick.pickImage(source: ImageSource.gallery);
    if(image!=null) {
      pickedImage=File(image.path);
      setState(() {

      });
     return pickedImage;
    }else{
      return null;
    }

  }



  // refresh() {
  //
  //   // CategoryMailProvider();
  //   var provider=Provider.of<CategoryMailProvider>(context);
  //   provider. fetchCategoryMails(categoryId: "2", index: 0);
  //   provider. fetchCategoryMails(categoryId: "3", index: 1);
  //   provider. fetchCategoryMails(categoryId: "4", index: 2);
  //   provider. fetchCategoryMails(categoryId: "1", index: 3);
  //
  //
  // }
}
