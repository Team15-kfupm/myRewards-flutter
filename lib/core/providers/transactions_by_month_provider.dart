import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/models/transactions_by_month.dart';

import '../services/db_services.dart';

final transactionsByMonthProvider = StreamProvider.autoDispose
    .family<List<TransactionsByMonthModel>, String>((ref, userId) {
  return DB().getTransactionsByMonth(userId);
});
