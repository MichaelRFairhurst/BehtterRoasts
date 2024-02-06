import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_config.freezed.dart';

@Freezed()
class RoastConfig with _$RoastConfig {
  const factory RoastConfig({
    required int tempInterval,
    required double targetDevelopment,
  }) = _RoastConfig;
}
