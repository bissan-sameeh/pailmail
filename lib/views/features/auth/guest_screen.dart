import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/helpers/routers/router.dart';
import '../../../core/helpers/routers/routes.dart';
import '../../../core/utils/constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../storage/shared_prefs.dart';

class GuestScreen extends StatefulWidget {
  const GuestScreen({Key? key}) : super(key: key);

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await AuthProvider().logout();
          await SharedPreferencesController().clear();
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Navigator.pushRepvylacement(context,
          //       MaterialPageRoute(builder: (_) => const LoginScreen()));
          //   setState(() {});
          // });
          NavigationRoutes().pushUntil(context, Routes.login_screen);
        },
        label: Text('Logout'),
        icon: Icon(Icons.logout_rounded),
        splashColor: kDarkGreyColor,
        backgroundColor: kPrimaryBlueColor,
        tooltip: 'Back to Login',
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Access Denied',
                  style: GoogleFonts.poppins(
                      color: kDarkGreyColor,
                      fontSize: 24,
                      letterSpacing: 0.25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Sorry, you don\'t have access.\n Please contact your administrator.',
                  style: GoogleFonts.poppins(
                      color: kGreyWhiteColor,
                      fontSize: 16,
                      letterSpacing: 0.25),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
