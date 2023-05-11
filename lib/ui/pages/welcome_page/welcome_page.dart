import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/sign_in_page/sign_in_page.dart';
import '../../../core/providers/shared_pref_provider.dart';
import '../../../utils/constants.dart';
import '../sign_in_page/widgets/upper_part.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});
  @override
  WelcomePageState createState() => WelcomePageState();
}

final offsetProvider = StateProvider<double>((ref) => 0);

class WelcomePageState extends ConsumerState<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final sharedPref = ref.watch(sharedPrefProvider);

    return sharedPref.when(data: (sharedPref) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              blackColor.withOpacity(0.75),
              secondaryColor,
              secondaryColor,
              secondaryColor,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              1.verticalSpace,
              const UpperPart(),
              InkWell(
                onTap: () {
                  if (sharedPref.getBool('isFirstTime') ?? true) {
                    Navigator.pushNamed(context, '/introPage').then(
                        (value) => sharedPref.setBool('isFirstTime', false));
                  } else {
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      transitionAnimationController: AnimationController(
                          vsync: Navigator.of(context),
                          duration: const Duration(milliseconds: 500)),
                      elevation: 0,
                      isScrollControlled: false,
                      useSafeArea: true,
                      isDismissible: true,
                      enableDrag: true,
                      builder: (BuildContext context) {
                        return const Scaffold(
                          resizeToAvoidBottomInset: true,
                          body: SingleChildScrollView(
                            child: SignInPage(),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  height: 60.h,
                  width: 318.w,
                  decoration: signInButtonStyle,
                  child: Center(
                    child: Text(
                      'Let\'s start',
                      style: signInButtonTextStyle,
                    ),
                  ),
                ),
              ),
              1.verticalSpace
            ],
          ),
        ),
      );
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    }, error: (error, stackTrace) {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
