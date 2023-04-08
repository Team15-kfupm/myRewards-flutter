import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_info_model.dart';
import '../services/auth_services.dart';

final userInfoProvider = StreamProvider<UserInfoModel>((ref) async* {
  final user = await AuthService().user.first;

  final userSnapshot =
      FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots();

  yield* userSnapshot.map((event) => UserInfoModel.fromSnapshot(event));
});
