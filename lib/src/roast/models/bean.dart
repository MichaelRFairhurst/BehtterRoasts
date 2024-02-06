import 'package:freezed_annotation/freezed_annotation.dart';

part 'bean.freezed.dart';

@Freezed()
class Bean with _$Bean {
  const factory Bean({
    required String name,
  }) = _Bean;
}
