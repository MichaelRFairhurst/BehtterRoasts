import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'control_log.freezed.dart';
part 'control_log.g.dart';

enum Control {
  p1,
  p2,
  p3,
  p4,
  p5,
  d,
}

@Freezed()
class ControlLog with _$ControlLog implements BaseLog {
  const factory ControlLog({
    required Duration time,
    required Control control,
  }) = _ControlLog;

  factory ControlLog.fromJson(Map<String, dynamic> json) =>
      _$ControlLogFromJson(json);
}
