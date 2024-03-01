import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramButton extends StatelessWidget {
  const ProgramButton(
    this.letter, {
    super.key,
  });

  final String letter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.red[800]!,
            width: 1.5,
          ),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.yellow, Colors.white],
          ),
        ),
        child: Center(
          child: Text(
            letter,
            style: GoogleFonts.cabin(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
