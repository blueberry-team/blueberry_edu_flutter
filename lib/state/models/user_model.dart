import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/user_model.freezed.dart';
part 'generated/user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String email,
    required String name,
    required String activity,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
