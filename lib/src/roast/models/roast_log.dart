import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_log.freezed.dart';

enum RoastPhase {
  dryEnd,
  firstCrackStart,
  firstCrackEnd,
}

@Freezed()
class RoastLog with _$RoastLog {
  const factory RoastLog({
    required Duration time,
    int? temp,
    RoastPhase? phase,
    Control? control,
	double? rateOfRise,
  }) = _RoastLog;
}
