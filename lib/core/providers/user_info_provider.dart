import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/services/auth_services.dart';
import '../models/user_info_model.dart';

class UserInfoProvider extends AsyncNotifier<UserInfoModel> {
  @override
  FutureOr<UserInfoModel> build() async {
    final user = await AuthService().user.first;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    return UserInfoModel.fromSnapshot(userDoc);
  }

  Future<void> verifyUser() async {
    // get user info from firebase document
    final user = await AuthService().user.first;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    state = AsyncValue.data(UserInfoModel.fromSnapshot(userDoc));
  }

  copyWith(
      {String? uid,
      String? name,
      String? email,
      String? phone,
      DateTime? birthDate,
      String? gender}) {
    state = AsyncValue.data(UserInfoModel(
        uid: uid ?? state.value!.uid,
        name: name ?? state.value!.name,
        email: email ?? state.value!.email,
        phone: phone ?? state.value!.phone,
        birthDate: birthDate ?? state.value!.birthDate,
        gender: gender ?? state.value!.gender));
  }
}
