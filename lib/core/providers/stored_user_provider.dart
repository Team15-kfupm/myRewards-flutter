import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_info_model.dart';

class StoredUserProvider extends AsyncNotifier<UserInfoModel> {
  @override
  FutureOr<UserInfoModel> build() {
    // get user info from firebase document
    return Future.value(UserInfoModel(
      uid: '',
      name: '',
      email: '',
      phone: '',
      birthDate: DateTime.now(),
      gender: '',
    ));
  }
}
