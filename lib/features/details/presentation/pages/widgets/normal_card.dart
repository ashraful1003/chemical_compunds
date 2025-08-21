import 'package:flutter/material.dart';

class NormalCard extends StatelessWidget {
  const NormalCard({required this.title, required this.description, super.key});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
        color: Color(0xFFEA5B6F),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 14),
          children: <InlineSpan>[
            TextSpan(
              text: title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: description),
          ],
        ),
      ),
    );
  }
}
