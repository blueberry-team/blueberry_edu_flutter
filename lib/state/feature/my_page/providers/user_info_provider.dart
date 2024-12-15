import 'package:blueberry_edu/state/data/auth/auth_repository.dart';
import 'package:blueberry_edu/state/data/fire_store/fire_store_repository.dart';
import 'package:blueberry_edu/state/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userInfoProvider =
    StateNotifierProvider.autoDispose<UserInfoNotifier, UserModelState>((ref) {
  final authInterface = ref.read(authRepositoryProvider);
  final fireStoreInterface = ref.read(fireStoreRepositoryProvider);
  return UserInfoNotifier(authInterface, fireStoreInterface);
});

class UserInfoNotifier extends StateNotifier<UserModelState> {
  final AuthInterface _authInterface;
  final FireStoreInterface _fireStoreInterface;

  UserInfoNotifier(this._authInterface, this._fireStoreInterface)
      : super(UserModelState());

  Future<void> getUserInfo() async {
    try {
      final user = await _authInterface.checkUser();
      final userModel = await _fireStoreInterface.getUserData(user?.uid ?? '');

      state = UserModelState(userModel: userModel);
    } catch (e) {
      print(e);
    }
  }
}

class UserModelState {
  final UserModel? userModel;

  UserModelState({
    this.userModel,
  });
}
