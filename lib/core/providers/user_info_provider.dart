import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_info_model.dart';
import 'auth_user_state_provider.dart';

final userInfoProvider =
    StreamProvider.autoDispose<UserInfoModel>((ref) async* {
  final user = ref.watch(authUserProvider).value;

  final userSnapshot =
      FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots();

  yield* userSnapshot.map((event) => UserInfoModel.fromSnapshot(event));
});
