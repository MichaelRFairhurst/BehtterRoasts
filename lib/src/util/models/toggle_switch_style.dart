import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:behmor_roast/src/config/theme.dart';

part 'toggle_switch_style.freezed.dart';

@freezed
class ToggleSwitchStyle with _$ToggleSwitchStyle {
  const factory ToggleSwitchStyle({
	required Color backgroundColor,
	required Color pillColor,
	@Default(EdgeInsets.all(3.0))
	EdgeInsets padding,
	@Default(EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0))
	EdgeInsets pillPadding,
	@Default(4.0)
	double gap,
	@Default(Radius.circular(64.0))
	Radius backgroundRadius,
	@Default(Radius.circular(32.0))
	Radius pillRadius,
	@Default(Color(0xFF202020))
	Color pillShadowColor,
	@Default(4.0)
	double pillElevation,
  }) = _ToggleSwitchStyle;

  static const defaults = ToggleSwitchStyle(
    backgroundColor: RoastAppTheme.metal,
    pillColor: RoastAppTheme.lilac,
  );
}
