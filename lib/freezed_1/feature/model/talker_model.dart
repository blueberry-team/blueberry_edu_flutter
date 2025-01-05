import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/talker_model.freezed.dart';

@freezed
class TalkerModel with _$TalkerModel {
  const factory TalkerModel({required String name, required String age}) =
      _TalkerModel;
}
