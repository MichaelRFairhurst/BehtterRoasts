import 'package:freezed_annotation/freezed_annotation.dart';

part 'temp_log.freezed.dart';

@Freezed()
class TempLog with _$TempLog {
  const factory TempLog({
    required Duration time,
	required int temp,
  }) = _TempLog;
}
