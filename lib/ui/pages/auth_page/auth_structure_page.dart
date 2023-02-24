import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/utils/constants.dart';

class AuthStructurePage extends StatefulWidget {
  const AuthStructurePage({Key? key}) : super(key: key);

  @override
  State<AuthStructurePage> createState() => _AuthStructurePageState();
}

class _AuthStructurePageState extends State<AuthStructurePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 392.h,
          width: 375.w,
          color: primaryColor,
          child: const Center(
            child: Icon(Icons.card_giftcard_outlined),
          ),
        ),
        Container(
          height: 435.h,
          width: 375.w,
          color: whiteColor,
          child: const Center(
            child: Text('Hello World'),
          ),
        )
      ],
    );
  }
}
