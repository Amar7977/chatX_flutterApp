// Chat Data Model
class ChatModel {
  final String name;
  final String message;
  final String image;
  final bool isOnline;

  ChatModel({
    required this.name,
    required this.message,
    required this.image,
    this.isOnline = false,
  });
}