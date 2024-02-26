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
	return DropdownButton<int>(
	  value: value,
	  onChanged: (value) => onChanged(value!),
	  items: const [
	    DropdownMenuItem(
		  value: 15,
		  child: Text('Every 15s'),
		),
	    DropdownMenuItem(
		  value: 30,
		  child: Text('Every 30s'),
		),
	    DropdownMenuItem(
		  value: 60,
		  child: Text('Every 60s'),
		),
	  ]
	);
  }
}
