import 'package:flutter/widgets.dart';

class AlignedExtraGridView extends StatelessWidget {
  const AlignedExtraGridView({
    required this.children,
    required this.crossAxisCount,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    super.key,
  });

  final int crossAxisCount;
  final List<Widget> children;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth / crossAxisCount;
        return Wrap(
          alignment: WrapAlignment.center,
          children: children.map((child) {
            return SizedBox(
              width: size,
              height: size,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: crossAxisSpacing / 2,
                  vertical: mainAxisSpacing / 2,
                ),
                child: child,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
