import 'package:flutter/material.dart';

class SuffixDoubleTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String suffix;

  const SuffixDoubleTextFieldWidget({
    required this.controller,
    required this.suffix, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: validateValue,
      keyboardType: TextInputType.number,
    );
  }

  void validateValue(String value) {
    if (value.endsWith(suffix)) {
      value = value.substring(0, value.length - suffix.length);
    }

    final asDouble = double.tryParse(value);

  }
}
