import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:behmor_roast/src/config/theme.dart';

part 'toggle_switch_style.freezed.dart';

@freezed
class ToggleSwitchStyle with _$ToggleSwitchStyle {
  const factory ToggleSwitchStyle({
	required Color backgroundColor,
	required Color pillColor,
  }) = _ToggleSwitchStyle;

  static const defaults = ToggleSwitchStyle(
    backgroundColor: RoastAppTheme.metalLight,
    pillColor: RoastAppTheme.lilac,
  );
}
