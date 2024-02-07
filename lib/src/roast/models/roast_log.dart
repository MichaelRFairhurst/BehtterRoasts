import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_log.freezed.dart';

@Freezed()
class RoastLog with _$RoastLog {
  const factory RoastLog({
    required Duration time,
    int? temp,
    Phase? phase,
    Control? control,
	double? rateOfRise,
  }) = _RoastLog;
}
