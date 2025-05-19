import 'package:flutter/material.dart';
import 'package:pailmail/core/helpers/routers/routes.dart';
import 'package:pailmail/views/features/home/drawer/settings/general_user_profile.dart';

import '../../../views/features/auth/auth_screen.dart';
import '../../../views/features/auth/guest_screen.dart';
import '../../../views/features/auth/splash_screen.dart';
import '../../../views/features/category/category_screen.dart';
import '../../../views/features/home/drawer/profile/profile_screen.dart';
import '../../../views/features/home/drawer/profile/update_profile_screen.dart';
import '../../../views/features/home/drawer/sender/senders.dart';
import '../../../views/features/home/drawer/settings/settings_screen.dart';
import '../../../views/features/home/home_screen.dart';
import '../../../views/features/inbox_mails/inbox_screen.dart';
import '../../../views/features/search/search_filters_screen.dart';
import '../../../views/features/search/search_screen.dart';
import '../../../views/features/senders/sender_screen.dart';
import '../../../views/features/status/status_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const SplashScreen(
          duration: Duration(seconds: 3),
        ),
      );
    //
    case Routes.search_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: SearchScreen(),
      );
    case Routes.login_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const LoginScreen(),
      );

    case Routes.home_screen:
      final args = settings.arguments as Map?;
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: settings,
      );

    case Routes.status_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const StatusScreen(),
      );
    case Routes.sender_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const SenderScreen(),
      );
    case Routes.inbox_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const InboxScreen(isDetails: false),
      );
    case Routes.category_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const CategoryScreen(),
      );
    case Routes.search_filters_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const SearchFiltersScreen(),
      );
    case Routes.settings_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const SettingsScreen(),
      );
    case Routes.profile_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const ProfileScreen(),
      );
    case Routes.senders:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const Senders(),
      );
    case Routes.general_user_profile_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const GeneralUserProfileScreen(
            image: '', name: '', email: '', role: '', id: ''),
      );
    case Routes.update_profile_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: UpdateProfileScreen(name: '', image: ''),
      );
    case Routes.guest_screen:
      return _getPageRoute(
        routeName: settings.name!,
        screen: const GuestScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No Route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({
  required String routeName,
  required Widget screen,
}) {
  return PageTransition(
    child: screen,
    type: PageTransitionType.rightToLeft,
  );
}

enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
}

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  PageTransition({
    required this.child,
    this.type = PageTransitionType.downToUp,
    this.curve = Curves.linear,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return child;
          },
          transitionDuration: duration,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            switch (type) {
              case PageTransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case PageTransitionType.rightToLeft:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(-1.0, 0.0),
                    ).animate(secondaryAnimation),
                    child: child,
                  ),
                );

              case PageTransitionType.downToUp:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.0, -1.0),
                    ).animate(secondaryAnimation),
                    child: child,
                  ),
                );

              case PageTransitionType.rightToLeftWithFade:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(-1.0, 0.0),
                      ).animate(secondaryAnimation),
                      child: child,
                    ),
                  ),
                );

              default:
                return FadeTransition(opacity: animation, child: child);
            }
          },
        );
}
