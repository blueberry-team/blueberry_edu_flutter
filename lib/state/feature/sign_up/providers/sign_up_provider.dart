import 'package:blueberry_edu/state/data/fire_store/fire_store_repository.dart';
import 'package:blueberry_edu/state/dto/sign_up_dto.dart';
import 'package:blueberry_edu/state/data/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>((ref) {
  final authInterface = ref.read(authRepositoryProvider);
  final fireStoreInterface = ref.read(fireStoreRepositoryProvider);
  return SignUpNotifier(authInterface, fireStoreInterface);
});

class SignUpNotifier extends StateNotifier<SignUpState> {
  final AuthInterface _authInterface;
  final FireStoreInterface _fireStoreInterface;

  SignUpNotifier(this._authInterface, this._fireStoreInterface)
      : super(SignUpState());

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String activity,
  }) async {
    try {
      final signUpDto = SignUpDto(
        email: email,
        password: password,
        name: name,
        activity: activity,
      );

      final signUpResult = await _authInterface.signUp(
        email: signUpDto.email,
        password: signUpDto.password,
      );

      final updatedSignUpDto = signUpDto.copyWith(
        id: signUpResult.user?.uid,
      );

      await _fireStoreInterface.saveUserData(updatedSignUpDto);

      state = SignUpState();
    } catch (e) {
      print(e);
    }
  }
}

class SignUpState {
  final SignUpDto? signUpDto;
  final bool isLoading;

  SignUpState({
    this.signUpDto,
    this.isLoading = false,
  });
}
