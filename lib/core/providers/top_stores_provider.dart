import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';

import '../services/db_services.dart';

final topStoresProvider = FutureProvider.family((ref, Map points) {
  print(points);
  return DB().getTopStores(points);
});
