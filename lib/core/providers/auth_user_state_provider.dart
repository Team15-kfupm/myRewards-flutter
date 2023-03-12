import 'package:riverpod/riverpod.dart';
import '../models/auth_user_model.dart';
import '../services/auth_services.dart';

final authUserProvider = StreamProvider<AuthUserModel>((ref) {
  return AuthService().user;
});
