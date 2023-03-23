import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/utils/constants.dart';

class ProgressPercentageBar extends StatefulWidget {
  const ProgressPercentageBar({Key? key}) : super(key: key);

  @override
  State<ProgressPercentageBar> createState() => _ProgressPercentageBarState();
}

class _ProgressPercentageBarState extends State<ProgressPercentageBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 39.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            widthFactor: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        5.verticalSpace,
        Text(
          '${(5 * 100).toStringAsFixed(0)}%',
          textAlign: TextAlign.center,
          style: signInButtonTextStyle,
        ),
      ],
    );
  }
}
