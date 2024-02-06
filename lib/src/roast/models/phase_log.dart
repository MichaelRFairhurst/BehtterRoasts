import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'phase_log.freezed.dart';

enum Phase {
  dryEnd,
  crack,
}

@Freezed()
class PhaseLog with _$PhaseLog implements BaseLog {
  const factory PhaseLog({
    required Duration time,
    required Phase phase,
  }) = _PhaseLog;
}
