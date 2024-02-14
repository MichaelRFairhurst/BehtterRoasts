import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/timer/models/temp_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:behmor_roast/src/roast/models/roast_config.dart';

part 'roast.freezed.dart';
part 'roast.g.dart';

@Freezed()
class Roast with _$Roast {
  const factory Roast({
    required String beanId,
    required RoastConfig config,
    required int roastNumber,
    required double weightIn,
    required double weightOut,
	@Default([])
	List<TempLog> tempLogs,
	@Default([])
	List<ControlLog> controlLogs,
	@Default([])
	List<PhaseLog> phaseLogs,
  }) = _Roast;

  factory Roast.fromJson(Map<String, dynamic> json) => _$RoastFromJson(json);
}
