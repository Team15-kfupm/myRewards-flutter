import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});
