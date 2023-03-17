
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_info_model.dart';


class UserInfoProvider extends StateNotifier<UserInfoModel> {
  UserInfoProvider()
      : super(UserInfoModel(

            uid: '',
            name: '',
            email: '',
            phone: '',
            birthDate: DateTime.now(),
            gender: ''));


  void setUserInfo(UserInfoModel userInfo) {
    state = userInfo;
  }
}
