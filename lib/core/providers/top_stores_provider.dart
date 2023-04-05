import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/db_services.dart';

final topStoresProvider = FutureProvider.family((ref, Map points) {
  return DB().getTopStores(points);
});
