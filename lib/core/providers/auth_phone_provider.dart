import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationIdNotifier extends StateNotifier<String> {
  VerificationIdNotifier() : super('');

  void setVerificationId(String verificationId) {
    state = verificationId;
  }
}
