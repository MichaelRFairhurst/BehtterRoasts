import 'package:freezed_annotation/freezed_annotation.dart';

part 'bean.freezed.dart';
part 'bean.g.dart';

@Freezed()
class Bean with _$Bean {
  const factory Bean({
    required String name,
  }) = _Bean;

  factory Bean.fromJson(Map<String, dynamic> json) => _$BeanFromJson(json);
}
