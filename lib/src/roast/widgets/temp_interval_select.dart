import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/util/models/toggle_switch_style.dart';
import 'package:behmor_roast/src/util/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';

class TempIntervalSelect extends StatelessWidget {
  const TempIntervalSelect({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final int value;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch<int>(
      onToggle: onChanged,
      style: const ToggleSwitchStyle(
        backgroundColor: Colors.transparent,
        pillColor: RoastAppTheme.lime,
        pillPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        pillElevation: 0,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      value: value,
      children: [
        ToggleSwitchOption<int>(
          value: 15,
          child: Text(
            'Every 15s',
            style: RoastAppTheme.materialTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: value == 15 ? FontWeight.w500 : FontWeight.normal),
          ),
        ),
        ToggleSwitchOption<int>(
          value: 30,
          child: Text(
            'Every 30s',
            style: RoastAppTheme.materialTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: value == 30 ? FontWeight.w500 : FontWeight.normal),
          ),
        ),
        ToggleSwitchOption<int>(
          value: 60,
          child: Text(
            'Every 60s',
            style: RoastAppTheme.materialTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: value == 60 ? FontWeight.w500 : FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
