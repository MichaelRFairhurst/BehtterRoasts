import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            button('P1'),
            button('P2'),
            button('P3'),
            button('P4'),
            button('P5'),
            button('D'),
          ],
        ),
        ElevatedButton.icon(
         icon: Icon(Icons.upcoming),
         //icon: Icon(Icons.flare),
         //icon: Icon(Icons.stream),
         //icon: Icon(Icons.new_releases),
         label: const Text('Log Crack'),
         onPressed: () {},
        ),
      ],
    );
  }

  Widget button(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        minimumSize: const Size(30, 30),
      ),
      child: Text(text),
      onPressed: () {},
    );
  }
}
