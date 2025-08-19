import 'package:flutter/material.dart';

class ChatMessage {
  final String sender;
  final String text;
  final bool isMe;
  String? reaction;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.isMe,
    this.reaction,
  });
}

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({
    Key? key,
    required String name,
    required String image,
  }) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<ChatMessage> messages = [
    ChatMessage(sender: "Divya", text: "Hello, How are you!", isMe: false),
    ChatMessage(sender: "Sanju", text: "I am fine, What about you?", isMe: true),
    ChatMessage(
      sender: "Sophia",
      text: "I found a recipe for that dish. Want me to send it over?",
      isMe: false,
    ),
    ChatMessage(sender: "Sanju", text: "Okay", isMe: true),
  ];

  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messages.add(ChatMessage(
        sender: "Sanju",
        text: _controller.text,
        isMe: true,
      ));
      _controller.clear();
    });
  }

  void _showReactions(GlobalKey key, int index) {
    // block reactions on my own messages
    if (messages[index].isMe) return;

    // remove previous overlay if any
    _overlayEntry?.remove();

    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // dismiss area
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            behavior: HitTestBehavior.translucent,
          ),
          Positioned(
            left: position.dx + renderBox.size.width / 4,
            top: position.dy - 40, // float above bubble
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: ["❤️", "😆", "🙂", "😂", "😭"].map((emoji) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          messages[index].reaction = emoji;
                        });
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildMessage(int index) {
    final msg = messages[index];
    final bubbleKey = GlobalKey();

    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        key: bubbleKey,
        onLongPress: () => _showReactions(bubbleKey, index),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          constraints: const BoxConstraints(maxWidth: 280),
          decoration: BoxDecoration(
            color: msg.isMe ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment:
            msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                msg.sender,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: msg.isMe ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                msg.text,
                style: TextStyle(
                  fontSize: 15,
                  color: msg.isMe ? Colors.white : Colors.black87,
                ),
              ),
              if (msg.reaction != null && !msg.isMe) ...[ // 👈 only show reactions on received msgs
                const SizedBox(height: 4),
                Text(
                  msg.reaction!,
                  style: const TextStyle(fontSize: 18),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/user1.png"),
        ),
        title: const Text("Divya", style: TextStyle(color: Colors.black)),
        actions: const [
          Icon(Icons.video_call, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) => _buildMessage(index),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user1.png"),
                  radius: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Message",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
