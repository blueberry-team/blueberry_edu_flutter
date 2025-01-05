import 'package:blueberry_edu/freezed_1/feature/model/talker_model.dart';
import 'package:blueberry_edu/freezed_1/feature/talker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inputRepositoryProvider =
    Provider<InputRepository>((ref) => InputRepository());

class InputRepository {
  Future<TalkerModel> saveUser(String name, String age) async {
    try {
      talkerInfo("InputRepository(saveUser)", "name: $name, age: $age");
      await Future.delayed(const Duration(milliseconds: 500)); // 가상의 지연 시간
      return TalkerModel(name: name, age: age);
    } catch (e) {
      throw Exception('Failed to save user');
    }
  }
}
