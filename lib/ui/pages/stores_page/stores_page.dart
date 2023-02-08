import 'package:flutter/material.dart';
import 'package:myrewards_flutter/ui/pages/stores_page/widgets/store_card.dart';

class StoresPage extends StatelessWidget {
  const StoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // opacity app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Stores',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              StoreCard(),
              StoreCard(),
              StoreCard(),
              StoreCard(),
              StoreCard(),
            ],
          ),
        ),
      ),
    );
  }
}
