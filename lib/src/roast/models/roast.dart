import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast_config.dart';

part 'roast.freezed.dart';

@Freezed()
class Roast with _$Roast {
  const factory Roast({
    required Bean bean,
    required RoastConfig config,
    required int roastNumber,
    required double weightIn,
    required double weightOut,
  }) = _Roast;
}
