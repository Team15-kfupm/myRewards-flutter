import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/services/db_services.dart';

final offerCodeProvider =
    StreamProvider.family((ref, String offerId) => DB().isExpired(offerId));
