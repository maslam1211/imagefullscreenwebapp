import 'package:flutter/material.dart';


class UrlInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onShowImage;

  const UrlInputField({
    super.key,
    required this.controller,
    required this.onShowImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Image URL',
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onShowImage,
          child: const Text('Show Image'),
        ),
      ],
    );
  }
}
