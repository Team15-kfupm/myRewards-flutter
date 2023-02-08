import 'package:flutter/material.dart';
import 'package:myrewards_flutter/ui/pages/store_page/widgets/offers.dart';
import 'package:myrewards_flutter/ui/pages/store_page/widgets/store_logo.dart';
import 'package:myrewards_flutter/ui/pages/store_page/widgets/transactions.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //transparent appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Offers(), StoreLogo()],
              ),
              SizedBox(
                height: 30,
              ),
              Transactions(),
            ],
          ),
        ));
  }
}
