import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_summary.freezed.dart';

@freezed
class RoastSummary with _$RoastSummary {
  const factory RoastSummary({
    required String beanName,
    required Duration totalTime,
	required Duration dryPhaseTime,
	required double dryPhasePercent,
	required Duration maillardPhaseTime,
	required double maillardPhasePercent,
	required Duration firstCrackPhaseTime,
	required double firstCrackPhasePercent,
	required Duration developmentPhaseTime,
	required double developmentPercent,
	required double developmentPercentTarget,
	required double weightLoss,
  }) = _RoastSummary;
}
