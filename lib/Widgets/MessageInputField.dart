import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget {
  final TextEditingController controller;
  final String profilePic;
  final VoidCallback onSend;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.profilePic,
    required this.onSend,
  });

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  bool _isTextNotEmpty = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkText);
  }

  void _checkText() {
    setState(() {
      _isTextNotEmpty = widget.controller.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkText);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePic),
            radius: 22,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: "Message",
                filled: true,
                fillColor: theme.colorScheme.secondary,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: !_isTextNotEmpty
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              "assets/logo/imageicon.png",
                              width: 36,
                              height: 36,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            onPressed: () => print("image tapped"),
                          ),
                          IconButton(
                            icon: Image.asset(
                              "assets/logo/micicon.png",
                              width: 36,
                              height: 36,
                              color: Theme.of(context).colorScheme.tertiary,
                            ), onPressed:() => print("mic tapped"),
                          ),
                        ],
                      )
                    : null,
              ),
            ),
          ),
          if (_isTextNotEmpty) // show send button only when text exists
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue, size: 28),
              onPressed: widget.onSend,
            ),
        ],
      ),
    );
  }
}
