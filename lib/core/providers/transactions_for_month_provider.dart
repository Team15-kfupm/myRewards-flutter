import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';

import 'auth_user_state_provider.dart';

final transactionsForMonthProvider = FutureProvider.autoDispose((ref) {
  final docId = DateFormat("yyyy-MM").format(DateTime.now());
  final user = ref.read(authUserProvider).value;
  return DB().getTransactionsForMonth(user!.uid, docId);
});
