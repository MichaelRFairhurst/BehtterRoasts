import 'package:behmor_roast/src/timer/models/temp_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_log.freezed.dart';

@Freezed()
class RoastLog with _$RoastLog {
  const factory RoastLog({
    required TempLog tempLog,
	double? rateOfRise,
  }) = _RoastLog;
}
