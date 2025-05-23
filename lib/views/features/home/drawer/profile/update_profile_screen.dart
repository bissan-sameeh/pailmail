import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/routers/router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/snckbar.dart';
import '../../../../../providers/auth_provider.dart';
import '../../../../../repositories/auth_repository.dart';
import '../../../../../storage/shared_prefs.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_auth_button_widget.dart';
import '../../../../widgets/custom_profile_image.dart';
import '../../../../widgets/custom_text_forn_field_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String name;
  final String image;
  UpdateProfileScreen({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>
    with ShowSnackBar {
  bool isUpdating = false;
  final _updateFormKey = GlobalKey<FormState>();
  TextEditingController updateNameController = TextEditingController();

  late Future<String>? newPath;
  File? pickedFile;
  String? filePath;
  String? currentImagePath;
  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return null;
    }
    File imageFile = File(pickedImage.path);
    return imageFile;
  }

  updateUser(File file) {
    if ( _updateFormKey.currentState!.validate() ) {

      setState(() {
        isUpdating = true;
      });
      AuthRepository().uploadImage(file, updateNameController.text).then(
            (value) async {

          await Provider.of<AuthProvider>(context, listen: false)
              .fetchCurrentUser();
          // set locally
          await SharedPreferencesController()
              .setData(PrefKeys.name.toString(), updateNameController.text);
          print('------------------------------${file.path}');
          // await SharedPrefrencesController().setData(PrefKeys.image.toString(),
          //     AuthProvider().currentUser.data?.user.image);
          // await SharedPrefrencesController()
          //     .setData(PrefKeys.image.toString(), file.path);
          showSnackBar(context,
              message: 'Profile has been successfully updated!');

          setState(() {});
          if (mounted) {
            NavigationRoutes()
                .jump(context, Routes.profile_screen, replace: true);
          }
        },
      );
    }
  }

  @override
  void initState() {
    updateNameController.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              child: Column(
                children: [
                  const CustomAppBar(widgetName: 'Edit Profile'),

                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [


                      pickedFile == null
                          ? CustomProfileImage(
                        image: NetworkImage(
                          '$imageUrl/${widget.image}',
                        ),
                      )
                          : CustomProfileImage(
                        image: FileImage(File(pickedFile!.path)),
                      ),
                      InkWell(
                        onTap: () async {
                          pickedFile = await pickImage();
                          if (pickedFile != null) {
                            filePath = pickedFile!.path;
                          }
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: kYellowColor,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: kYellowColor),
                            child: const Icon(
                              size: 32,
                              Icons.camera_alt,
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 60),

                  // -- Form Fields
                  Form(
                    key: _updateFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: CustomTextFormFieldWidget(
                            hint: 'New Username',
                            controller: updateNameController,
                          ),
                        ),
                        SizedBox(height: 60.h),
                        CustomAuthButtonWidget(
                          child: isUpdating
                              ? progressSpinkit
                              : Text(
                            'update',
                            style: GoogleFonts.poppins(
                                color: kWhiteColor,
                                fontSize: 18,
                                letterSpacing: 0.44),
                          ),
                          onTap: () {
                            updateUser(pickedFile!);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
