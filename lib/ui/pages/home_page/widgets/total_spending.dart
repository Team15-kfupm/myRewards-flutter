import 'package:flutter/material.dart';

class TotalSpending extends StatefulWidget {
  const TotalSpending({Key? key}) : super(key: key);

  @override
  State<TotalSpending> createState() => _TotalSpendingState();
}

class _TotalSpendingState extends State<TotalSpending> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          '453.78',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Text(
          ' sar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
