import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/db_services.dart';
import 'auth_user_state_provider.dart';

final topStoresPointsProvider = StreamProvider<Map>(
  (ref) async* {
    final user = ref.read(authUserProvider);
    yield* DB().getTopStoresPoints(user.asData!.value.uid);
  },
);
