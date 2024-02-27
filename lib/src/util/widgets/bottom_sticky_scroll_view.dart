import 'package:flutter/material.dart';

class BottomStickyScrollView extends StatelessWidget {
  final List<Widget> children;

  const BottomStickyScrollView({
	required this.children,
	super.key,
  });

  @override
  Widget build(BuildContext context) {
	return LayoutBuilder(
	  builder: (context, constraints) {
		return SingleChildScrollView(
		  reverse: true,
		  child: ConstrainedBox(
		    constraints: BoxConstraints(
			  minWidth: constraints.maxWidth,
			  minHeight: constraints.maxHeight,
			),
			child: Align(
			  alignment: Alignment.topCenter,
			  child: Column(
			    mainAxisSize: MainAxisSize.min,
				crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
			  ),
			)
		  ),
		);
	  },
	);

  }
}
