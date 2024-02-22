import 'package:behmor_roast/src/config/theme.dart';
import 'package:flutter/material.dart';

class RoastTipWidget extends StatefulWidget {
  const RoastTipWidget({
	required this.tips,
	super.key,
  });

  final Set<String> tips;

  @override
  RoastTipWidgetState createState() => RoastTipWidgetState();
}

class RoastTipWidgetState extends State<RoastTipWidget> with SingleTickerProviderStateMixin {

  final tips = <String>[];
  final dismissed = <String>{};
  late final AnimationController animation;

  RoastTipWidgetState();

  @override
  void initState() {
	super.initState();
	animation = AnimationController(
	  vsync: this,
	  duration: const Duration(milliseconds: 150),
	);

	tips.addAll(widget.tips);
	if (tips.isNotEmpty) {
	  animation.forward();
	}
  }

  @override
  void didUpdateWidget(RoastTipWidget oldWidget) {
	super.didUpdateWidget(oldWidget);

    if (oldWidget.tips.containsAll(widget.tips)
		&& widget.tips.containsAll(oldWidget.tips)) {
	  return;
	}

	setState(() {
	  if (tips.isEmpty) {
		tips.addAll(widget.tips.toSet()..removeAll(dismissed));
		if (tips.isNotEmpty) {
		  animation.forward();
		}
	  } else {
		mergeUpdatedTips();
	  }
	});
  }

  void mergeUpdatedTips() {
    if (!widget.tips.contains(tips[0])) {
	  animation.reverse().then(reverseAnimationComplete);
	}

    final newTips = widget.tips.toSet()
	    ..remove(tips[0])
		..removeAll(dismissed);

    for (int i = 1; i < tips.length; ++i) {
	  if (widget.tips.contains(tips[i])) {
		newTips.remove(tips[i]);
	  } else {
		tips.removeAt(i);
		i--;
	  }
	}

    tips.addAll(newTips);
  }

  void reverseAnimationComplete(void _) {
	tips.removeAt(0);
	setState(() {});
	if (tips.isNotEmpty) {
	  animation.forward();
    }
  }

  @override
  void dispose() {
	animation.dispose();
	super.dispose();
  }

  @override
  Widget build(BuildContext context) {
	return SizeTransition(
	  sizeFactor: animation,
	  child: Container(
		decoration: const BoxDecoration(
		  color: RoastAppTheme.capuccino,
		),
		padding: const EdgeInsets.all(8.0),
        child: Row(
		  children: [
			const Icon(Icons.school, color: RoastAppTheme.crema),
			const SizedBox(width: 8),
			Expanded(
			  child: Text(
			    'Roasting Tip: ${tips.isEmpty ? '' : tips.first}',
				style: const TextStyle(color: RoastAppTheme.crema),
			  ),
			),
			const SizedBox(width: 8),
			SizedBox(
			  width: 16,
			  height: 16,
			  child: ElevatedButton(
				style: RoastAppTheme.tinyButtonTheme.style,
				onPressed: () {
				  dismissed.add(tips.first);
				  animation.reverse().then(reverseAnimationComplete);
				},
				child: const Icon(Icons.cancel, size: 12),
			  ),
			),
		  ],
		),
	  ),
	);
  }
}
