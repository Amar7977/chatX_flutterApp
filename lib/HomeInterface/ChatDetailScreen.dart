import 'package:flutter/material.dart';
import 'package:chatx/Widgets/info.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final String? originalText;
  final String time;
  String? reaction;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.originalText,
    this.reaction,
  });
}

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String profilePic;

  const ChatDetailScreen({
    Key? key,
    required this.name,
    required this.profilePic,
  }) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late List<ChatMessage> messagesList;
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();

    // Convert info.dart messages map -> ChatMessage objects
    messagesList = messages.map((msg) {
      return ChatMessage(
        text: msg["text"] as String,
        isMe: msg["isMe"] as bool,
        time: msg["time"] as String,
        originalText: msg["originalText"] as String?,
      );
    }).toList();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messagesList.add(ChatMessage(
        text: _controller.text,
        isMe: true,
        time: "Now",
      ));
      _controller.clear();
    });
  }

  void _showReactions(GlobalKey key, int index) {
    if (messagesList[index].isMe) return;

    _overlayEntry?.remove();

    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
              _overlayEntry = null;
            },
            behavior: HitTestBehavior.translucent,
          ),
          Positioned(
            left: position.dx + renderBox.size.width / 4,
            top: position.dy - 40,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
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
                          messagesList[index].reaction = emoji;
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
    final msg = messagesList[index];
    final bubbleKey = GlobalKey();

    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            key: bubbleKey,
            onLongPress: () => _showReactions(bubbleKey, index),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              constraints: const BoxConstraints(maxWidth: 280),
              decoration: BoxDecoration(
                gradient: msg.isMe
                    ? const LinearGradient(
                  colors: [Color(0xFF0D80F2), Color(0xFF074A8C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
                    : LinearGradient(
                  colors: [Colors.grey.shade100, Colors.grey.shade500],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg.text,
                    style: TextStyle(
                      fontSize: 15,
                      color: msg.isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                  if (msg.originalText != null) ...[
                    const SizedBox(height: 4),
                    ExpandableOriginalText(
                      text: msg.originalText!,
                      isMe: msg.isMe,
                    ),
                  ],
                  if (msg.reaction != null && !msg.isMe) ...[
                    SizedBox(height: 4),
                    Text(
                      msg.reaction!,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ]
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8,left: 8),
            child: Padding(
              padding: const EdgeInsets.only(right: 12, left: 12, top: 2),
              child: Text(
                msg.time,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          )
        ],
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
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg'),
          ),
        ),
        title: Text(info[0]['name'].toString(), style: const TextStyle(fontSize: 20,color: Colors.black)),
        actions: [
          IconButton(
            icon: Image.asset("assets/logo/cameraicon.png", width: 26, height: 26, color: Colors.black,),
            onPressed: () => print("mic tapped"),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: messagesList.length,
              itemBuilder: (context, index) => _buildMessage(index),
            ),
          ),
          _buildBottomInput(),
        ],
      ),
    );
  }

  Widget _buildBottomInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.only(bottom: 6),
      color: Colors.white,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg'),
            radius: 22,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Message",
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset("assets/logo/imageicon.png", width: 36, height: 36),
                      onPressed: () => print("image tapped"),
                    ),
                    IconButton(
                      icon: Image.asset("assets/logo/micicon.png", width: 36, height: 36),
                      onPressed: () => print("mic tapped"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue, size: 28),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ExpandableOriginalText extends StatefulWidget {
  final String text;
  final bool isMe;

  const ExpandableOriginalText({
    Key? key,
    required this.text,
    required this.isMe,
  }) : super(key: key);

  @override
  _ExpandableOriginalTextState createState() => _ExpandableOriginalTextState();
}

class _ExpandableOriginalTextState extends State<ExpandableOriginalText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Column(
        crossAxisAlignment:
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            _expanded
                ? widget.text
                : (widget.text.length > 40
                ? widget.text.substring(0, 40) + "..."
                : widget.text),
            style: TextStyle(
              fontSize: 13,
              color: widget.isMe ? Colors.white70 : Colors.black54,
            ),
          ),
          if (widget.text.length > 40)
            Text(
              _expanded ? "Show less" : "Show more",
              style: TextStyle(
                fontSize: 12,
                color: widget.isMe ? Colors.white60 : Colors.blueGrey,
              ),
            ),
        ],
      ),
    );
  }
}


