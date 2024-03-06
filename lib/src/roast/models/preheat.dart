import 'package:freezed_annotation/freezed_annotation.dart';

part 'preheat.freezed.dart';
part 'preheat.g.dart';

@freezed
class Preheat with _$Preheat {
  const factory Preheat({
    required DateTime start,
    required Duration end,
    required int temp,
  }) = _Preheat;

  factory Preheat.fromJson(Map<String, dynamic> json) =>
      _$PreheatFromJson(json);
}
