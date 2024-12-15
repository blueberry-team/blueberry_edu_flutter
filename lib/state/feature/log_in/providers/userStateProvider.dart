import 'package:blueberry_edu/state/data/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  final authInterface = ref.read(authRepositoryProvider);
  return UserNotifier(authInterface);
});

class UserNotifier extends StateNotifier<User?> {
  final AuthInterface _authInterface;

  UserNotifier(this._authInterface) : super(null) {
    checkUserState();
  }

  Future<void> checkUserState() async {
    try {
      final user = await _authInterface.checkUser();
      state = user;
    } catch (e) {
      print(e);
    }
  }
}
