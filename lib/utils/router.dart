import 'package:flutter/material.dart';

import 'package:myrewards_flutter/ui/pages/home_page/home_page.dart';
import 'package:myrewards_flutter/ui/pages/profile_page/profile_page.dart';
import 'package:myrewards_flutter/ui/pages/store_page/store_page.dart';
import 'package:myrewards_flutter/ui/shared/pages/auth_checker/auth_checker.dart';

import '../ui/pages/sign_in_page/otp_page.dart';
import '../ui/pages/stores_page/stores_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const HomePage());

    case '/home':
      return MaterialPageRoute(builder: (context) => const HomePage());

    case '/profile':
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    case '/otp':
      return MaterialPageRoute(
        builder: (context) => const OTPPage(),
      );
    default:
      return MaterialPageRoute(builder: (context) => const AuthChecker());
  }
}
