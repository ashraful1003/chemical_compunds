import 'package:flutter/material.dart';

class FoldingCard extends StatefulWidget {
  const FoldingCard({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  State<FoldingCard> createState() => _FoldingCardState();
}

class _FoldingCardState extends State<FoldingCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
          color: Color(0xFFEA5B6F),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${widget.title}${isExpanded ? ':' : ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                ),
              ],
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
