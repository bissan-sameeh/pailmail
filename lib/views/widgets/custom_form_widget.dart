import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pailmail/core/helpers/routers/router.dart';
import 'package:pailmail/core/utils/show_bottom_sheet.dart';
import 'package:pailmail/providers/categories_providers/categories_provider.dart';
import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';
import '../../core/helpers/api_helpers/api_response.dart';
import '../../core/helpers/api_helpers/app_exception.dart';
import '../../core/utils/awesome_dialog.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/snckbar.dart';
import '../../repositories/sender_repository.dart';
import '../features/category/category_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_auth_button_widget.dart';
import 'custom_app_bar.dart';

class SenderFormWidget extends StatefulWidget {
  final bool isEdit;
  final String? initialName;
  final String? initialPhone;
  final String? initialCity;
  final String? initialCategoryName;
  final int? initialCategoryId;
  final int? senderId;

  const SenderFormWidget({
    super.key,
    required this.isEdit,
    this.initialName,
    this.initialPhone,
    this.initialCity,
    this.initialCategoryName,
    this.initialCategoryId,
    this.senderId,
  });

  @override
  State<SenderFormWidget> createState() => _SenderFormWidgetState();
}

class _SenderFormWidgetState extends State<SenderFormWidget>
    with MyShowBottomSheet, AwesomeDialogMixin, ShowSnackBar {
  late TextEditingController senderController;
  late TextEditingController phoneController;
  late TextEditingController cityController;

  String selectedCategoryName = '';
  int? categoryId;
  bool hasUserSelectedCategory = false;
  bool isLoading = false;
  String _selectedCountry = '';

  String handleErrorMessage(dynamic errorData) {
    if (errorData is Map<String, dynamic>) {
      if (errorData.containsKey('errors')) {
        final errors = errorData['errors'] as Map<String, dynamic>;
        return errors.values.first.first; // مثل: "The mobile has already been taken."
      }
    }
    return errorData.toString();
  }

  // String handleErrorMessage(String errorData) {
  //   try {
  //     if (errorData is Map<String, dynamic>) {
  //
  //
  //
  //       if (errorData.contains('The mobile has already been taken')) {
  //         return errorData['message'];
  //       }
  //     }
  //
  //     return "حدث خطأ غير معروف.";
  //   } catch (_) {
  //     return "تعذر تحليل رسالة الخطأ.";
  //   }
  // }

  @override
  void initState() {
    super.initState();
    senderController = TextEditingController(text: widget.initialName ?? '');
    phoneController = TextEditingController(text: widget.initialPhone ?? '');
    cityController = TextEditingController(text: widget.initialCity ?? '');
    selectedCategoryName = widget.initialCategoryName ?? 'Other';
    categoryId = widget.initialCategoryId ?? 1;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.h),
      child: Container(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20.r),
          color: kWhiteColor,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
                widgetName: widget.isEdit == true
                    ? "Edit ${widget.initialName}"
                    : "Add Sender",
                onTap: () {
                  Provider.of<CategoriesProvider>(context, listen: false)
                      .setCategoryIndex(categoryIndex: 1);
                  setState(() {
                    selectedCategoryName = '';
                    categoryId = 1;
                    hasUserSelectedCategory = false;
                  });
                },
              ),
              CustomTextField(
                controller: senderController,
                hintText: 'Sender Name',
                icon: const Icon(Icons.perm_identity),
                withoutPrefix: false,
                validator: (value) =>
                    value!.isEmpty ? 'Sender Name is required' : null,
                customFontSize: 16,
              ),
              const Divider(),

              CustomTextField(
                controller: phoneController,
                textInputType: TextInputType.number,
                hintText: 'Mobile Number',
                icon: const Icon(Icons.mobile_friendly),
                withoutPrefix: false,
                validator: (value) =>
                    value!.isEmpty ? 'Mobile is required' : null,
                customFontSize: 16,
              ),
              Divider(),
              CustomTextField(
                controller: cityController,
                withoutPrefix: false,
                hintText:
                    cityController.text.isEmpty ? 'city' : cityController.text,
                icon: const Icon(Icons.location_city),
                suffixIcon: Icons.arrow_drop_down,
                withoutSuffix: false,
                suffixFunction: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        cityController.text = country.name;
                      });
                    },
                  );
                },
                customFontSize: 16,
              ),
              Divider(),

              /// Category row
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.0.w),
                      child: const Text("Category"),
                    ),
                    const Spacer(),
                    Consumer<CategoriesProvider>(
                      builder: (context, categoryProvider, _) {
                        if (categoryProvider.allCategories.status ==
                            ApiStatus.LOADING) {
                          return const Text("Loading...");
                        } else if (categoryProvider.allCategories.status ==
                            ApiStatus.COMPLETED) {
                          if (hasUserSelectedCategory) {
                            final newCategory = categoryProvider.allCategories
                                .data?[categoryProvider.categoryPosition];
                            selectedCategoryName = newCategory?.name ?? '';
                            categoryId = newCategory?.id;
                          }
                          return Text(selectedCategoryName);
                        } else {
                          return const Text("Error loading categories");
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          hasUserSelectedCategory = true;
                        });
                        showSheet(
                            context,
                            CategoryScreen(
                              category_id: categoryId,
                            ));
                      },
                    )
                  ],
                ),
              ),

              CustomAuthButtonWidget(
                child: isLoading
                    ? progressSpinkit
                    : Text(
                        widget.isEdit ? "Update Sender!" : "Add Sender!",
                        style: const TextStyle(color: kWhiteColor),
                      ),
                onTap: () async {
                  if (isLoading) return;
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });

                  try {
                    if (widget.isEdit) {
                      print("skksks");
                      try {
                        print("sender id ${widget.senderId}");
                        await SenderRepository().updateSender(
                          senderController.text,
                          phoneController.text,
                          cityController.text,
                          categoryId,
                          widget.senderId!,
                        );

                        if (context.mounted) {
                          print("object");
                          showSenderSuccessDialog(
                            context: context,
                            senderName: senderController.text,
                            onOk: () {
                              Provider.of<CategoriesProvider>(context,
                                      listen: false)
                                  .fetchAllCategories();
                              if (context.mounted) Navigator.pop(context);
                            },
                            title: 'Updated Successfully',
                            desc:
                                'Updated successfully ${senderController.text}',
                          );
                        }
                      } catch (e) {
                        print(e.toString());

                        final errorData = e.runtimeType;
                        print("🟢 errorData: $errorData");

                          String message = handleErrorMessage(errorData);


                          // showSnackBar(context,
                          //     message: message, error: true);
                        buildFailedDialog(context,message,() => NavigationRoutes().pop(context),);

                        print(e.toString());
                      }
                    } else {
                      await SenderRepository().createSender(
                        address: cityController.text,
                        name: senderController.text,
                        mobile: phoneController.text,
                        categoryId: categoryId.toString(),
                      );
                      if (context.mounted) {
                        print("Trying to show dialog...");

                        showSenderSuccessDialog(
                          context: context,
                          senderName: senderController.text,
                          onOk: () {
                            Provider.of<CategoriesProvider>(context,
                                    listen: false)
                                .fetchAllCategories();

                            Provider.of<CategoriesProvider>(context,
                                    listen: false)
                                .setCategoryIndex(categoryIndex: 1);

                            if (context.mounted) Navigator.pop(context);
                          },
                          title: 'Sender Added!',
                          desc: 'Successfully added ${senderController.text}',
                        );
                      }
                    }
                  } catch (err) {
                    print("sssssssssssssssssssss");
                    print(err.toString());

                    if (context.mounted) {
                      String message = "Unexpected error!";

                      if (err is BadRequestException) {
                        final errorData = err.message;
                        print("🟢 errorData: $errorData");

                      message = handleErrorMessage(errorData);
                      print(message);
                      }
                      // print("err +$message");

                      buildFailedDialog(context,message,() => NavigationRoutes().pop(context),);

                    //  showSnackBar(context,message: message,error: true);
                    }
                  } finally {
                    if (mounted) {
                      setState(() => isLoading = false);
                    }
                  }
                }},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
