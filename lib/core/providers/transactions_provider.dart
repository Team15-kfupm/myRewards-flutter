import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/providers/user_info_provider.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';

final transactionsProvider = StreamProvider((ref) {
  final userId = ref.read(userInfoProvider).value!.uid;
  return DB().getTransactionsByMonth(userId);
});
