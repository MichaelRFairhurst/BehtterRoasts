import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:behmor_roast/src/config/theme.dart';

part 'toggle_switch_style.freezed.dart';

@freezed
class ToggleSwitchStyle with _$ToggleSwitchStyle {
  const factory ToggleSwitchStyle({
	required Color backgroundColor,
	required Color pillColor,
	@Default(EdgeInsets.all(6.0))
	EdgeInsets padding,
	EdgeInsets? pillPadding,
	@Default(4.0)
	double gap,
	@Default(Radius.circular(128.0))
	Radius backgroundRadius,
	@Default(Radius.circular(64.0))
	Radius pillRadius,
  }) = _ToggleSwitchStyle;

  static const defaults = ToggleSwitchStyle(
    backgroundColor: RoastAppTheme.metal,
    pillColor: RoastAppTheme.lilac,
  );
}
