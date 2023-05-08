import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/avatar_with_welcome.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/home_store_card_list.dart';
import 'package:myrewards_flutter/ui/pages/home_page/widgets/credits_card.dart';
import 'package:myrewards_flutter/ui/pages/statistics_page/statistics_page.dart';
import 'package:myrewards_flutter/ui/pages/stores_page/stores_page.dart';

import '../../../utils/constants.dart';
import '../settings_page/settings_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _selectedController;
  late AnimationController _unselectedController;
  @override
  void initState() {
    DB().isNewUser();
    super.initState();
    _selectedController = AnimationController(vsync: this);
    _selectedController.duration = const Duration(milliseconds: 10);
    _selectedController.forward(from: 0.0);

    // stop the animation at 64%
    _selectedController.addListener(() {
      if (_selectedController.value >= 0.64) {
        _selectedController.stop();
      }
    });
    _unselectedController = AnimationController(vsync: this);
    _unselectedController.duration = const Duration(milliseconds: 1);
    _unselectedController.forward(from: 0.6);
    // stop the animation at 64%
    _unselectedController.addListener(() {
      if (_unselectedController.value >= 0.64) {
        _unselectedController.stop();
      }
    });
  }

  int _selectedIndex = 0;
  List<bool> isSelected = [true, false, false, false];
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
                    onTap: () {
                      Navigator.pushNamed(context, '/searchPage');
                    },
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
      const StatisticsPage(),
      const SettingsPage(),
    ];
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          onTap: (value) {
            if (isSelected[value]) return;
            isSelected.setAll(0, [false, false, false, false]);
            isSelected[value] = true;
            _selectedIndex = value;
            _selectedController.forward(from: 0.0);
            _selectedController.duration = const Duration(milliseconds: 1000);
            // stop the animation at 64%
            _selectedController.addListener(() {
              if (_selectedController.value >= 0.9) {
                _selectedController.stop();
              }
            });
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: Lottie.asset(
                'assets/lottie/home.json',
                controller:
                    isSelected[0] ? _selectedController : _unselectedController,
                height: 30.h,
                onLoaded: (composition) {
                  _selectedController.duration = composition.duration;
                },
                fit: BoxFit.cover,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Lottie.asset(
                'assets/lottie/store.json',
                height: 50.h,
                controller:
                    isSelected[1] ? _selectedController : _unselectedController,
                fit: BoxFit.cover,
              ),
              label: 'Stores',
            ),
            BottomNavigationBarItem(
              icon: Lottie.asset(
                'assets/lottie/statistics.json',
                controller:
                    isSelected[2] ? _selectedController : _unselectedController,
                height: 50.h,
                fit: BoxFit.cover,
              ),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  child: Lottie.asset(
                'assets/lottie/settings.json',
                controller:
                    isSelected[3] ? _selectedController : _unselectedController,
                height: 35.h,
                fit: BoxFit.cover,
              )),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlueAccent[700],
        ),
      ),
    );
  }
}
