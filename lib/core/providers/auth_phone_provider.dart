import 'package:riverpod/riverpod.dart';

class VerificationIdNotifier extends StateNotifier<String> {
  VerificationIdNotifier() : super('');

  void setVerificationId(String verificationId) {
    state = verificationId;
  }
}
