import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myrewards_flutter/core/models/store_model.dart';
import 'package:myrewards_flutter/ui/pages/stores_page/widgets/store_card.dart';

import '../../../core/providers/stores_provider.dart';
import '../../../utils/constants.dart';

class StoreSearchPage extends ConsumerStatefulWidget {
  const StoreSearchPage({super.key});

  @override
  StoreSearchPageState createState() => StoreSearchPageState();
}

class StoreSearchPageState extends ConsumerState<StoreSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<StoreCard>? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_runSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _runSearch() async {
    final query = _searchController.text.trim();
    final storesList = ref.read(storesProvider);
    List<StoreModel> stores = [];
    storesList.whenData((value) {
      setState(() {
        stores = value;
      });
    });

    if (query.isNotEmpty) {
      final searchResults = stores
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
      setState(() {
        _searchResults = [];
        for (var element in searchResults) {
          _searchResults!.add(StoreCard(store: element));
        }
      });
    } else {
      setState(() {
        _searchResults = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          elevation: 0,
          title: TextField(
            controller: _searchController,
            style: profileSelectedGenderTextStyle,
            decoration: InputDecoration(
              filled: true,
              fillColor: secondaryColor,
              focusColor: secondaryColor,
              hoverColor: secondaryColor,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: secondaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: secondaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.h),
              hintText: 'Search stores by name',
              hintStyle: profileSelectedGenderTextStyle,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
          child: _searchResults == null
              ? Center(
                  child: Text(
                    'Enter a search term to get started.',
                    style: statCategoryLabelTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              : _searchResults!.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/lottie/no_search_result.json',
                            height: 200.h,
                            width: 200.w,
                          ),
                          Text(
                            'No stores are found',
                            style: statCategoryLabelTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      children: _searchResults!),
        ));
  }
}
