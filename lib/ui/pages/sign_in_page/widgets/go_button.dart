import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/auth_services.dart';
import '../../../../utils/constants.dart';

class GoButton extends ConsumerStatefulWidget {
  const GoButton({Key? key}) : super(key: key);

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
      isLoading = true;
      setState(() {
        
      });
        AuthService().signInWithPhoneNumber(ref);

        Navigator.pushNamed(context, '/otp');
      },
      child: Container(
        height: 60.h,
        width: 318.w,
        decoration: signInButtonStyle,
        child: Center(
          child: isLoading ? const CircularProgressIndicator() : Text(
            'GO!',
            style: signInButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
