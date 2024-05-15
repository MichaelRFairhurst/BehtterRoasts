import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_summary.freezed.dart';

@freezed
class RoastSummary with _$RoastSummary {
  const factory RoastSummary({
    required String beanName,
    required String roastNumber,
    required Duration totalTime,
    Duration? preheatTime,
    Duration? preheatGap,
    required Duration dryPhaseTime,
    required double dryPhasePercent,
    required Duration maillardPhaseTime,
    required double maillardPhasePercent,
    required Duration firstCrackPhaseTime,
    required double firstCrackPhasePercent,
    Duration? secondCrackPhaseTime,
    double? secondCrackPhasePercent,
    required Duration developmentPhaseTime,
    required double developmentPercent,
    required double developmentPercentTarget,
    required double weightIn,
    required double weightOut,
    required double weightLoss,
    String? notes,
  }) = _RoastSummary;
}
