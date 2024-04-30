import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOnboardPage extends StatelessWidget {
  const CustomOnboardPage(
      {super.key,
      required this.label,
      required this.controller,
      this.isNumber = false,
      this.maxLines = 1});

  final String label;
  final TextEditingController controller;
  final int maxLines;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          inputFormatters:
              isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
