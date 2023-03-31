import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/models/store_model.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';

final storesProvider = FutureProvider<List<StoreModel>>((ref) {
  return DB().getStoresWithOffers();
});
