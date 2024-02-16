import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckTempWidget extends ConsumerStatefulWidget {
  const CheckTempWidget({
    required this.shownTime,
    required this.label,
    required this.onSubmit,
	super.key,
  });

  final Duration shownTime;
  final String label;
  final void Function(Duration, int) onSubmit;

  @override
  CheckTempWidgetState createState() => CheckTempWidgetState();
}

class CheckTempWidgetState extends ConsumerState<CheckTempWidget> {
  int state = 0;

  @override
  Widget build(BuildContext context) {
    const baseDigits = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];

    return Column(
	  crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
	    Container(
		  padding: const EdgeInsets.all(8.0),
	      child: Text(widget.label),
		),
		const SizedBox(height: 4.0),
	    Container(
		  margin: const EdgeInsets.symmetric(horizontal: 4.0),
		  padding: const EdgeInsets.all(8.0),
		  decoration: BoxDecoration(
		    //color: RoastAppTheme.cremaLight,
		    //color: RoastAppTheme.metal,
		    color: Colors.white,
		    borderRadius: BorderRadius.circular(8.0),
		  ),
	      child: Text(state.toString()),
		),
		const SizedBox(height: 4.0),
	    for (final row in baseDigits)
		  buildDigitRow(row),
		buildRow([
		  buildButton(
		    label: "Delete",
		    onPressed: () {
			  setState(() {
			    state = (state / 10).floor();
			  });
			},
	      ),
		  buildDigit(0),
		  buildButton(
		    label: "Done",
		    onPressed: () {
			  final now = ref.read(timerServiceProvider).elapsed()!;
			  widget.onSubmit(now, state);
			},
	      ),
		]),
	  ],
    );
  }

  Widget buildRow(List<Widget> children) {
	return Row(
	  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
	  children: children.map((child) =>
	    Expanded(
		  child: Container(
		    padding: const EdgeInsets.symmetric(horizontal: 4.0),
		    child: child,
		  ),
		),
	  ).toList(),
    );
  }

  Widget buildDigitRow(List<int> digits) {
	return buildRow([
	  for (final digit in digits)
        buildDigit(digit),
	]);
  }

  Widget buildDigit(int digit) {
	return buildButton(
	  label: digit.toString(),
	  onPressed: () {
	    setState(() {
	      state = state * 10 + digit;
	    });
	  },
	);
  }

  Widget buildButton({required String label, required void Function() onPressed}) {
	return ElevatedButton(
	  onPressed: onPressed,
	  style: RoastAppTheme.keypadButtonTheme.style,
	  child: Text(label),
	);
  }
}
