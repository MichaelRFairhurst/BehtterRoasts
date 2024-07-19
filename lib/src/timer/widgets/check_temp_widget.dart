import 'package:behmor_roast/src/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckTempWidget extends ConsumerStatefulWidget {
  const CheckTempWidget({
    required this.onSubmit,
    required this.title,
    this.onChanged,
    super.key,
  });

  final Widget title;
  final void Function(int) onSubmit;
  final void Function()? onChanged;

  @override
  CheckTempWidgetState createState() => CheckTempWidgetState();
}

class CheckTempWidgetState extends ConsumerState<CheckTempWidget> {
  int state = 0;

  @override
  Widget build(BuildContext context) {
    const baseDigits = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: widget.title,
        ),
        const SizedBox(height: 6.0),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(state.toString()),
        ),
        const SizedBox(height: 4.0),
        for (final row in baseDigits) buildDigitRow(row),
        buildRow([
          buildButton(
            label: "Delete",
            style: RoastAppTheme.keypadDeleteButtonTheme.style,
            onPressed: () {
              setState(() {
                state = (state / 10).floor();
              });
            },
          ),
          buildDigit(0),
          buildButton(
            label: "Done",
            style: RoastAppTheme.keypadDoneButtonTheme.style,
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
      children: children
          .map(
            (child) => Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: child,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildDigitRow(List<int> digits) {
    return buildRow([
      for (final digit in digits) buildDigit(digit),
    ]);
  }

  Widget buildDigit(int digit) {
    return buildButton(
      label: digit.toString(),
      onPressed: () {
        setState(() {
          state = state * 10 + digit;
          widget.onChanged?.call();
        });
      },
    );
  }

  Widget buildButton(
      {required String label,
      required void Function() onPressed,
      ButtonStyle? style}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? RoastAppTheme.keypadButtonTheme.style,
      child: Text(label),
    );
  }
}
