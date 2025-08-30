import 'package:chatx/DataModel/ChatMessage.dart';
import 'package:chatx/Widgets/MessageBubble.dart';
import 'package:chatx/Widgets/MessageInputField.dart';
import 'package:flutter/material.dart';
import 'package:chatx/Widgets/info.dart';
import 'package:translator/translator.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String profilePic;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.profilePic,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<ChatMessageModel> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GoogleTranslator _translator = GoogleTranslator();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();

    final translated = await _translator.translate(text, to: 'hi');

    setState(() {
      _messages.add(ChatMessageModel(
        text: text,
        isMe: true,
        translatedText: translated.text, time: '',
      ));
    });

    _scrollToBottom();
  }

  void _setReaction(int index, String emoji) {
    setState(() {
      _messages[index] = _messages[index].copyWith(reaction: emoji);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        elevation: 1,
        leading: Padding(
          padding:  EdgeInsets.only(left: 8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.profilePic),
          ),
        ),
        title: Text(widget.name, style: theme.textTheme.titleMedium),
        actions: [
          IconButton(
            icon: Image.asset(
              "assets/logo/cameraicon.png",
              width: 26,
              height: 26,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            onPressed: () => print("camera tapped"),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (_, i) => MessageBubble(
                message: _messages[i],
                senderName: _messages[i].isMe ? "You" : widget.name,
                onReact: (emoji) => _setReaction(i, emoji),
              ),
            ),
          ),
          MessageInputField(
            controller: _controller,
            profilePic: widget.profilePic,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}