import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';

import '../services/db_services.dart';

final topStoresPointsProvider = StreamProvider.family(
  (ref, String userId) async* {
    yield* DB().getTopStoresPoints(userId);
  },
);
