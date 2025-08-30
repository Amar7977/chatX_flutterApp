import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableOriginalText extends StatefulWidget {
  final String text;
  final bool isMe;
  const ExpandableOriginalText({
    super.key,
    required this.text,
    required this.isMe,
  });

  @override
  State<ExpandableOriginalText> createState() => _ExpandableOriginalTextState();
}

class _ExpandableOriginalTextState extends State<ExpandableOriginalText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final isLong = widget.text.length > 40;
    final displayText = _expanded || !isLong
        ? widget.text
        : "${widget.text.substring(0, 40)}...";

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Column(
        crossAxisAlignment: widget.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            displayText,
            style: TextStyle(
              fontSize: 13,
              color: widget.isMe ? Colors.white70 : Colors.black54,
            ),
          ),
          if (isLong)
            Text(
              _expanded ? "Show less" : "Show more",
              style: TextStyle(
                fontSize: 12,
                color: widget.isMe ? Colors.white60 : Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
