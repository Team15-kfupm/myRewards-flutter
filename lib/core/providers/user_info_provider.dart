import 'package:myrewards_flutter/core/models/user_info_model.dart';
import 'package:riverpod/riverpod.dart';

class UserInfoProvider extends StateNotifier<UserInfoModel> {
  UserInfoProvider()
      : super(UserInfoModel(
            name: 'Ahmed Mohamed',
            email: 'user_user@exapmle.com',
            phone: '0512345678',
            birthDate: DateTime.now(),
            gender: 'Male'));

  void setUserInfo(UserInfoModel userInfo) {
    state = userInfo;
  }
}
