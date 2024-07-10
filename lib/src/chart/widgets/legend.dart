import 'package:behmor_roast/src/config/theme.dart';
import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  const Legend({
    required this.items,
    this.wrap = true,
    super.key,
  });

  final bool wrap;
  final List<LegendItem> items;

  @override
  Widget build(BuildContext context) {
    if (wrap) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.0,
        children: items,
      );
    }

    return Column(
      children: items,
    );
  }
}

class LegendItemColorCircle extends StatelessWidget {
  const LegendItemColorCircle({
    required this.color,
    this.border,
    super.key,
  });

  final Color color;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        border: border == null ? null : Border.fromBorderSide(border!),
      ),
      child: const SizedBox(
        width: 8,
        height: 8,
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  LegendItem({
    required Color color,
    BorderSide? colorBorder,
    required String text,
    super.key,
  })  : colorWidget = LegendItemColorCircle(color: color, border: colorBorder),
        textWidget = Text(text);

  const LegendItem.custom({
    required this.colorWidget,
    required this.textWidget,
    super.key,
  });

  final Widget colorWidget;
  final Widget textWidget;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: RoastAppTheme.materialTheme.textTheme.bodySmall!,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              colorWidget,
              const SizedBox(width: 4),
              textWidget,
            ],
          ),
        ],
      ),
    );
  }
}
