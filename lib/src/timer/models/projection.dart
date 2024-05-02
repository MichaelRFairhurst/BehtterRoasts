import 'package:freezed_annotation/freezed_annotation.dart';

part 'projection.freezed.dart';

@Freezed()
class Projection with _$Projection {
  const factory Projection({
    required Duration? roastTime,
    required Duration? timeRemaining,
    required Duration? timeToOverheat,
    required double? currentTemp,
    required double? copyRoastTempDiff,
    required double? temp30s,
    required double? temp60s,
  }) = _Projection;
}
