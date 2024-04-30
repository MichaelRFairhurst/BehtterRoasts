import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'instruction.freezed.dart';

@freezed
class CoreInstruction with _$CoreInstruction {
  const factory CoreInstruction({
    required int index,
    required int? temp,
    required Duration time,
    required Control control,
    @Default(false) bool skipped,
  }) = _CoreInstruction;
}

@freezed
class TemporalInstruction with _$TemporalInstruction {
  const factory TemporalInstruction({
    required Duration time,
    required CoreInstruction core,
  }) = _TemporalInstruction;
}
