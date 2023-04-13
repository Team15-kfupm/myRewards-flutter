import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/ui/pages/home_page/home_page.dart';
import 'package:myrewards_flutter/ui/pages/settings_page/settings_page.dart';
import 'package:myrewards_flutter/ui/pages/sms_testing/sms_testing.dart';
import 'package:myrewards_flutter/ui/pages/statistics_page/donut_chart.dart';

import '../../../../core/providers/auth_user_state_provider.dart';

import '../../../../core/providers/user_info_provider.dart';
import '../../../pages/sign_in_page/sign_in_page.dart';

class AuthChecker extends ConsumerStatefulWidget {
  const AuthChecker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StaState();
}

class _StaState extends ConsumerState<AuthChecker> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authUserProvider);

    return authState.when(
      data: (user) {
        final userData = ref.watch(userInfoProvider);
        return userData.when(
          data: (userInfo) {
            return const HomePage();
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          // should return a page that shows a form to fill in the user's info page
          error: (error, stack) {
            log(error.toString());
            return const SettingsPage();
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const SignInPage(),
    );
  }
}
