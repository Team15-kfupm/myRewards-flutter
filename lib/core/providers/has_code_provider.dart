import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/db_services.dart';

final hasOtherCodeProvider =
    StreamProvider.family<bool, String>((ref, storeId) async* {
  yield* DB().hasOtherCode(storeId);
});
