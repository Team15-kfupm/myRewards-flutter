import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants.dart';

class TransactionsCategory extends StatefulWidget {
  const TransactionsCategory({super.key});

  @override
  State<TransactionsCategory> createState() => _TransactionsCategoryState();
}

class _TransactionsCategoryState extends State<TransactionsCategory> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.w,
                  ),
                  decoration: BoxDecoration(
                    color: firstShimmerColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '30%',
                    style: statCategoryPercentageTextStyle,
                  ),
                ),
                10.horizontalSpace,
                Text(
                  'Category Name',
                  style: statCategoryTypeTextStyle,
                ),
              ],
            ),
            Text(
              '100 SAR',
              style: statCategoryTypeTextStyle,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return 10.verticalSpace;
      },
      itemCount: 10,
    );
  }
}
