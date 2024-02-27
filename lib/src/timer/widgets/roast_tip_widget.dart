import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
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

class RoastTipWidgetState extends State<RoastTipWidget> {

  final tips = <String>[];
  final dismissed = <String>{};

  RoastTipWidgetState();

  @override
  void initState() {
	super.initState();
	tips.addAll(widget.tips);
  }

  @override
  void didUpdateWidget(RoastTipWidget oldWidget) {
	super.didUpdateWidget(oldWidget);

    if (oldWidget.tips.containsAll(widget.tips)
		&& widget.tips.containsAll(oldWidget.tips)) {
	  return;
	}

	setState(() {
	  tips..clear()..addAll(widget.tips.toSet()..removeAll(dismissed));
	});
  }

  @override
  Widget build(BuildContext context) {
	final tip = tips.isEmpty ? null : tips.first;

	return AnimatedPopUp(
	  child: tip == null ? null : Container(
	    key: Key(tip),
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
			    'Roasting Tip: $tip',
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
				  setState(() {
					dismissed.add(tips.first);
					tips.removeAt(0);
				  });
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
