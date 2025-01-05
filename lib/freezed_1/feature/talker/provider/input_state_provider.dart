import 'package:blueberry_edu/freezed_1/feature/model/talker_model.dart';
import 'package:blueberry_edu/freezed_1/feature/talker.dart';
import 'package:blueberry_edu/freezed_1/feature/talker/data/input_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inputStateProvider =
    StateNotifierProvider<InputStateNotifier, InputState>((ref) {
  final repository = ref.watch(inputRepositoryProvider);
  return InputStateNotifier(repository);
});

class InputStateNotifier extends StateNotifier<InputState> {
  InputStateNotifier(this._inputRepository) : super(InputState());

  final InputRepository _inputRepository;

  Future<void> updateTalker(String name, String age) async {
    try {
      final result = await _inputRepository.saveUser(name, age);
      talkerInfo("InputStateNotifier(updateTalker)", "result: $result");
      state = state.copyWith(talkerModel: result);
    } catch (e) {
      talkerInfo("InputStateNotifier(updateTalker)", "error: $e");
    }
  }
}

class InputState {
  final TalkerModel? talkerModel;

  InputState({this.talkerModel});

  InputState copyWith({
    TalkerModel? talkerModel,
  }) {
    return InputState(talkerModel: talkerModel ?? this.talkerModel);
  }
}
