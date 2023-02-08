import 'package:flutter/material.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/offer_progress_bar.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/offer_dots_progress.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    //vertical list of offers
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Offer $index'),
              index % 2 == 0
                  ? const OfferDotsProgress()
                  : const OfferProgressBar(),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 30,
          );
        },
      ),
    );
  }
}
