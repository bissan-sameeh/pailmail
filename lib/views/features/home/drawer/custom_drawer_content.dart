import 'package:pailmail/storage/shared_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/routers/router.dart';

class CustomDrawerContent extends StatelessWidget {
  const CustomDrawerContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ListTileTheme(
      textColor: Colors.white,
      iconColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: screenSize.width * 0.65,
            height: screenSize.height / 7,
            margin: const EdgeInsets.only(
              top: 24.0,
              bottom: 64.0,
            ),
            child: Image.asset(
              'assets/images/logo.png',
              height: 100.h,
              width: 100.w,
            ),
          ),
          menuListTile(Icons.home, 'home'.tr(), () {
            NavigationRoutes().jump(
              context,
              Routes.home_screen,
            );
          }),
          menuListTile(Icons.account_circle_rounded, 'profile'.tr(), () {
            NavigationRoutes().jump(
              context,
              Routes.profile_screen,
            );
          }),
          menuListTile(Icons.contact_page, 'senders'.tr(), () {
            NavigationRoutes().jump(context, Routes.senders);
          }),
          SharedPreferencesController().roleName == 'admin'
              ? menuListTile(Icons.settings, 'user_management'.tr(), () {
                  NavigationRoutes().jump(
                    context,
                    Routes.settings_screen,
                  );
                })
              : SizedBox(),
          const Spacer(),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white54,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Text('terms_of_service_privacy_policy'.tr()),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuListTile(IconData icon, String title, Function() onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        title.tr(),
      ),
    );
  }
}
