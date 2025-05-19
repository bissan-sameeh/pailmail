import 'package:flutter/material.dart';

import '../../../core/helpers/routers/router.dart';
import '../../../core/utils/constants.dart';
import '../../../storage/shared_prefs.dart';
import '../../widgets/custom_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  final Duration duration;

  const SplashScreen({super.key, required this.duration});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final prefs = SharedPreferencesController();

  void checkLogin() async {
    await SharedPreferencesController().initPref(); // تأكد من التهيئة هنا

    if (prefs.loggedIn && mounted) {
      print('+++++++++++++++++++++++++++++${prefs.roleId}');
      if (prefs.roleId == 1) {
        NavigationRoutes().jump(context, Routes.guest_screen, replace: true);
      } else {
        print("token"+prefs.token);
        print("name"+prefs.name);
        print("name"+prefs.image);

        NavigationRoutes().jump(context, Routes.home_screen, replace: true);
      }

    } else {
      NavigationRoutes().jump(context, Routes.login_screen, replace: true);
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: widget.duration, vsync: this)
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              checkLogin();
              // NavigationRoutes().jump(context, Routes.login_screen, replace: true);
            }
          });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlueColor,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Center(
            child: CustomLogoWidget(),
          );
        },
      ),
    );
  }
}
