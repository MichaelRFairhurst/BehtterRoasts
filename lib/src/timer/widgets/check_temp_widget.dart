import 'package:flutter/material.dart';

class CheckTempWidget extends StatefulWidget {
  const CheckTempWidget({
    required this.onSubmit,
    required this.label,
	Key? key
  }) : super(key: key);

  final String label;
  final void Function(int) onSubmit;

  @override
  CheckTempWidgetState createState() => CheckTempWidgetState();
}

class CheckTempWidgetState extends State<CheckTempWidget> {
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
		    color: Theme.of(context).colorScheme.secondary,
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
			  widget.onSubmit(state);
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
	  child: Text(label),
	);
  }
}
