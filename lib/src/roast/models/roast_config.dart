import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_config.freezed.dart';
part 'roast_config.g.dart';

@Freezed()
class RoastConfig with _$RoastConfig {
  const factory RoastConfig({
    required int tempInterval,
    int? preheatTarget,
    Duration? preheatTimeEst,
    required double targetDevelopment,
  }) = _RoastConfig;

  factory RoastConfig.fromJson(Map<String, dynamic> json) =>
      _$RoastConfigFromJson(json);
}
