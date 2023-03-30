import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/home_store_card.dart';

class HomeStoresCardList extends StatefulWidget {
  const HomeStoresCardList({Key? key}) : super(key: key);

  @override
  State<HomeStoresCardList> createState() => _HomeStoresCardListState();
}

class _HomeStoresCardListState extends State<HomeStoresCardList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          cacheExtent: 99999999999,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: const HomeStoreCard(),
            );
          }),
          separatorBuilder: (context, index) {
            return 16.verticalSpace;
          },
          itemCount: 5),
    );
  }
}
