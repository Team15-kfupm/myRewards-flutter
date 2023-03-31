import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/models/user_info_model.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';
import 'package:myrewards_flutter/utils/router.dart' as router;
// ignore: depend_on_referenced_packages
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'core/providers/auth_phone_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

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

final userInfoProvider = AsyncNotifierProvider<UserInfoProvider, UserInfoModel>(
    () => UserInfoProvider());

//async provider

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
