import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/sign_in_page/sign_in_page.dart';

import '../../../../core/services/auth_services.dart';
import '../../../../utils/constants.dart';

class GoButton extends ConsumerStatefulWidget {
  final String phoneNumber;
  const GoButton({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  GoButtonState createState() => GoButtonState();
}

final isLoadingProvider = StateProvider<bool>((ref) => false);

class GoButtonState extends ConsumerState<GoButton> {
  @override
  Widget build(BuildContext context) {
    var isLoading = ref.watch(isLoadingProvider);

    return InkWell(
      onTap: () {
        if (widget.phoneNumber.isEmpty ||
            !phoneNumberRegex.hasMatch(widget.phoneNumber)) {
          Flushbar(
            message: 'Please enter a valid phone number',
            duration: const Duration(milliseconds: 1300),
            flushbarStyle: FlushbarStyle.FLOATING,
            backgroundColor: Colors.red,
            flushbarPosition: FlushbarPosition.TOP,
          ).show(context);
          return;
        }

        if (isLoading) {
          Navigator.pushNamed(context, '/otp');

          return;
        }

        ref.read(phoneProvider.notifier).state =
            '+966${widget.phoneNumber.substring(1).trim()}';
        AuthService().signInWithPhoneNumber(
            ref, "+966${widget.phoneNumber.substring(1).trim()}");
        ref.read(isLoadingProvider.notifier).state = true;

        Navigator.pushNamed(context, '/otp');
      },
      child: Container(
        height: 60.h,
        width: 318.w,
        decoration: signInButtonStyle,
        child: Center(
          child: Text(
            'GO!',
            style: signInButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
