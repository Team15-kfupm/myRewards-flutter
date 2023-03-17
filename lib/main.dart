import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/models/user_info_model.dart';
import 'package:myrewards_flutter/core/providers/stored_user_provider.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';
import 'package:myrewards_flutter/utils/router.dart' as router;

import 'core/providers/auth_phone_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

final verificationIdProvider =
    StateNotifierProvider<VerificationIdNotifier, String>(
        (ref) => VerificationIdNotifier());

final userInfoProvider = StateNotifierProvider<UserInfoProvider, UserInfoModel>(
    (ref) => UserInfoProvider());

//async provider
final storedUserProvider =
    AsyncNotifierProvider<StoredUserProvider, UserInfoModel>(() {
  return StoredUserProvider();
});

// final isActiveSessionProvider = StateProvider<bool>((ref) => false);
// final prevPhoneNumberProvider = StateProvider<String>((ref) => '');


class MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/',
          onGenerateRoute: router.generateRoute,
        );
      },
    );
  }
}
