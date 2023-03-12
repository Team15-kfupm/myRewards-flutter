import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myrewards_flutter/core/models/auth_user_model.dart';
import 'package:myrewards_flutter/main.dart';

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

  Future<void> signInWithPhoneNumber(WidgetRef ref) async {
    _auth.verifyPhoneNumber(
      phoneNumber: '+96655351033',
      verificationCompleted: ((phoneAuthCredential) async {
         log('verify success');
        final user = await _auth.signInWithCredential(phoneAuthCredential);
       

        log(user.toString());
      }),
      verificationFailed: (FirebaseAuthException e) {
        log('verify failed');
        log(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        ref
            .read(verificationIdProvider.notifier)
            .setVerificationId(verificationId);
        log('code sent');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('code auto retrieval timeout');
      },
      timeout: const Duration(minutes: 2),
    );
  }

  Future<String> verifyOTP(String verification, String token) async {
    PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
        verificationId: verification, smsCode: token);
    try {
      final user = await _auth.signInWithCredential(phoneCredential);
      _userFromFirebaseUser(user.user!);
      return '';
    } catch (e) {
      print('not verified OTP');
      print(e.toString());
      return e.toString();
    }
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
