import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoTitle extends StatelessWidget {
  const LogoTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset('images/logo_transparent.svg', height: 32),
        ),
        Expanded(
          child: Text(text, overflow: TextOverflow.fade),
        ),
      ],
    );
  }
}
