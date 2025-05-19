import 'dart:io';

import 'package:pailmail/providers/auth_provider.dart';
import 'package:pailmail/views/features/home/drawer/profile/update_profile_screen.dart';
import 'package:pailmail/views/widgets/custom_auth_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helpers/api_helpers/api_response.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../widgets/custom_profile_container_image.dart';
import '../../../../widgets/custom_profile_menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? pickedFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: kLightBlueColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: kGradient,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (_, authProvider, __) {
          if (authProvider.currentUser.status == ApiStatus.LOADING) {
            return const Center(
              child: spinkit,
            );
          }
          if (authProvider.currentUser.status == ApiStatus.ERROR) {
            return Center(
              child: Text('${authProvider.currentUser.message}'),
            );
          }
          String? userName = authProvider.currentUser.data?.user.name;
          String? userImage = authProvider.currentUser.data?.user.image ?? '';
          String? userEmail = authProvider.currentUser.data?.user.email;
          String? userRole =
              authProvider.currentUser.data!.user.role!.name ?? '';

          return SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomProfileContainerImage(userImage: userImage),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileMenuWidget(
                        viewRoles: false,
                        title: "$userName",
                        icon: Icons.person,
                      ),
                      ProfileMenuWidget(
                        viewRoles: false,
                        title: "$userEmail",
                        icon: Icons.alternate_email_outlined,
                      ),
                      ProfileMenuWidget(
                        viewRoles: false,
                        title: "$userRole",
                        icon: Icons.recent_actors_outlined,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              CustomAuthButtonWidget(
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                        color: kWhiteColor, fontSize: 18, letterSpacing: 0.44),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return UpdateProfileScreen(
                          name: userName!,
                          image: userImage,
                        );
                      },
                    ));
                    // NavigationRoutes().jump(
                    //     context, Routes.update_profile_screen,
                    //     replace: true,
                    //
                    // );
                  }),
            ]),
          );
        },
      ),
    );
  }
}
