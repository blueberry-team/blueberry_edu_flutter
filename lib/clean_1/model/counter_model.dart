import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_model.freezed.dart';

@freezed
class CounterModel with _$CounterModel {
  const factory CounterModel({
    required int value,
  }) = _CounterModel;
}
