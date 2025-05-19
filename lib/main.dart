import 'package:pailmail/providers/attachment_provider.dart';
import 'package:pailmail/providers/categories_providers/categories_provider.dart';
import 'package:pailmail/providers/categories_providers/category_mail_provider.dart';

import 'package:pailmail/providers/sender_provider.dart';
import 'package:pailmail/providers/status_provider.dart';
import 'package:pailmail/providers/tag_provider.dart';

import 'package:pailmail/providers/auth_provider.dart';

import 'package:pailmail/providers/mails_provider.dart';

import 'package:pailmail/providers/general_users_provider.dart';
import 'package:pailmail/providers/roles_provider.dart';
import 'package:pailmail/storage/shared_prefs.dart';
import 'package:pailmail/views/features/auth/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/helpers/routers/route_helper.dart';
import 'core/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await SharedPreferencesController().initPref();

  // await SharedPrefrencesController().initPref();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: false,
      useOnlyLangCode: true,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.  @override
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryMailProvider>(
          create: (context) => CategoryMailProvider(),
        ),
        ChangeNotifierProvider<SenderProvider>(
          create: (_) => SenderProvider(),
        ),
        ChangeNotifierProvider<TagProvider>(
          create: (_) => TagProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<RoleProvider>(create: (_) => RoleProvider()),
        ChangeNotifierProvider<MailProvider>(create: (_) => MailProvider()),
        ChangeNotifierProvider<StatusProvider>(create: (_) => StatusProvider()),
        ChangeNotifierProvider<GeneralUsersProvider>(
            create: (_) => GeneralUsersProvider()),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (context) => CategoriesProvider(),
        ),  ChangeNotifierProvider<AttachmentProvider>(
          create: (context) => AttachmentProvider(),
        ),

      ],
      child: ScreenUtilInit(
          designSize: const Size(428, 812),
          builder: (context, child) {
            return MaterialApp(
              theme: ThemeData(scaffoldBackgroundColor: kBackgroundColor),
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: generateRoute,




              home: const SplashScreen(duration: Duration(seconds: 3)),
            );
          }),
    );
  }
}
