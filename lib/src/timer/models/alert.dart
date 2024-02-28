import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert.freezed.dart';

enum Severity {
  warning,
  alert,
}

enum AlertKind {
  smokeSuppressor,
  willOverheat,
  willShutOff,
}

@freezed
class Alert with _$Alert {
  const factory Alert({
	required Severity severity,
	required AlertKind kind,
	required String message,
  }) = _Alert;
}
