import 'package:chatx/DataModel/ChatMessage.dart';
import 'package:chatx/Widgets/ExpandableOriginalText.dart';
import 'package:chatx/Widgets/ReactionPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final String senderName;
  final ValueChanged<String> onReact;

  const MessageBubble({
    super.key,
    required this.message,
    required this.senderName,
    required this.onReact,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMe = message.isMe;

    // GlobalKey to get bubble position for reaction pop-up
    final bubbleKey = GlobalKey();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Sender Name
            Text(
              senderName,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isMe ? Colors.grey : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Message Bubble with AnimatedSize
            GestureDetector(
              onLongPress: () => _showReactions(context, bubbleKey),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Container(
                  key: bubbleKey,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 14),
                  constraints: const BoxConstraints(maxWidth: 280),
                  decoration: BoxDecoration(
                    gradient: isMe
                        ? const LinearGradient(
                      colors: [Color(0xFF0D80F2), Color(0xFF074A8C)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                        : LinearGradient(
                      colors: [Colors.grey, Colors.grey.shade300],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Message Text
                      Text(
                        message.text,
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black87,
                          fontSize: 15,
                        ),
                      ),

                      // Translated Text (Expandable)
                      if (message.translatedText != null)
                        ExpandableOriginalText(
                          text: message.translatedText!,
                          isMe: isMe,
                        ),

                      // Reaction Emoji
                      if (message.reaction != null &&
                          message.reaction!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            message.reaction!,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReactions(BuildContext context, GlobalKey bubbleKey) {
    final overlay = Overlay.of(context);
    final renderBox = bubbleKey.currentContext?.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero);
    final size = renderBox?.size;

    if (offset == null || size == null) return;

    late OverlayEntry entry;
    final controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 200),
    );
    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack, // springy pop
    );

    entry = OverlayEntry(
      builder: (_) => GestureDetector(
        onTap: () => controller.reverse().then((_) => entry.remove()),
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx + size.width / 2 - 240, // center the picker
              top: offset.dy - 70, // show above bubble
              width: 270, // width of reaction picker
              child: ScaleTransition(
                scale: animation,
                alignment: Alignment.bottomCenter,
                child: ReactionPicker(
                  onSelect: (emoji) {
                    if (message.reaction == emoji) {
                      onReact(""); // remove reaction
                    } else {
                      onReact(emoji); // set new reaction
                    }
                    controller.reverse().then((_) => entry.remove());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    overlay.insert(entry);
    controller.forward();
  }
}
