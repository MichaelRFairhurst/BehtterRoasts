import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'temp_log.freezed.dart';
part 'temp_log.g.dart';

@Freezed()
class TempLog with _$TempLog implements BaseLog {
  const factory TempLog({
    required Duration time,
    required int temp,
  }) = _TempLog;

  factory TempLog.fromJson(Map<String, dynamic> json) =>
      _$TempLogFromJson(json);
}
