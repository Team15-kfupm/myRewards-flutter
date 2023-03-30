import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/avatar_with_welcome.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/home_store_card_list.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/credits_card.dart';
import 'package:myrewards_flutter/ui/pages/stores_page/stores_page.dart';

import '../../../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AvatarWithWelcome(),
                  InkWell(
                    onLongPress: () {},
                    child: Container(
                        width: 42.w,
                        height: 42.h,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: settingsAppBarIconBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          color: blackColor,
                          size: 20.r,
                        )),
                  ),
                ],
              ),
              32.verticalSpace,
              const CreditsCard(),
              32.verticalSpace,
              const HomeStoresCardList(),
            ],
          )),
      const StoresPage(),
      const Center(
        child: Text('Statistics Page'),
      ),
      Center(
        child: InkWell(
            onTap: () => AuthService().signOut(),
            child: const Text('Settings Page')),
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              label: 'Stores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_rounded),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: secondaryColor,
        ),
      ),
    );
  }
}
