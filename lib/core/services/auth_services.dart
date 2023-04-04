import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/models/auth_user_model.dart';
import 'package:myrewards_flutter/main.dart';

import '../../ui/pages/sign_in_page/widgets/go_button.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  AuthUserModel? _userFromFirebaseUser(User user) {
    return AuthUserModel(uid: user.uid);
  }

  // // sign in with email and password
  // Future signInWithEmailAndPassword() async {
  //   try {
  //     final result = await _auth.signInWithEmailAndPassword(
  //         email: 'emad@emad.com', password: '12345678');
  //     final user = result.user;
  //     return _userFromFirebaseUser(user!);
  //   } catch (e) {
  //     log(e.toString());
  //     return null;
  //   }
  // }

  int _forceResendingToken = 0;

  Future<void> signInWithPhoneNumber(WidgetRef ref, String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: ((phoneAuthCredential) {
        log('verify success');

        _auth.signInWithCredential(phoneAuthCredential);
        ref.read(isLoadingProvider.notifier).state = false;
      }),
      verificationFailed: (FirebaseAuthException e) {
        ref.read(isLoadingProvider.notifier).state = false;
        log('verify failed');
        log(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        log('code sent');

        ref
            .read(verificationIdProvider.notifier)
            .setVerificationId(verificationId);
        ref.read(isLoadingProvider.notifier).state = false;

        _forceResendingToken = resendToken!;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('code auto retrieval timeout');

        ref.read(isLoadingProvider.notifier).state = false;
      },
      timeout: const Duration(seconds: 30),
      forceResendingToken: _forceResendingToken,
    );
  }

  Future<void> verifyOTP(String verification, String token) async {
    PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
        verificationId: verification, smsCode: token);

    final user = await _auth.signInWithCredential(phoneCredential);

    _userFromFirebaseUser(user.user!);
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // auth change user stream
  Stream<AuthUserModel> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!)!);
  }
}
