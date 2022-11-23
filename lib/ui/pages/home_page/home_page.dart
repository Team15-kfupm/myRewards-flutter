import 'package:flutter/material.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/bottom_nav_bar.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/categories_chart.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/offers.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/total_spending.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TotalSpending(),
              SizedBox(
                height: 30,
              ),
              CategoriesChart(),
              SizedBox(
                height: 30,
              ),
              Offers(),
            ],
          )),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
