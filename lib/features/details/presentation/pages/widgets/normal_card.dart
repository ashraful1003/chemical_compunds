import 'package:flutter/material.dart';

class NormalCard extends StatelessWidget {
  const NormalCard({required this.title, required this.description, super.key});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12.0),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: description, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
