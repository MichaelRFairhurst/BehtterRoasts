import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert.freezed.dart';

enum Severity {
  warning,
  alert,
}

enum AlertKind {
  preheatMax,
  smokeSuppressorOn,
  smokeSuppressorOff,
  willOverheat,
  willShutOff,
  pastSecondCrack,
}

@freezed
class Alert with _$Alert {
  const factory Alert({
    required Severity severity,
    required AlertKind kind,
    required String message,
  }) = _Alert;
}
