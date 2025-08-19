import 'package:chatx/DataModel/ChatModel.dart';
import 'package:chatx/HomeInterface/ChatDetailScreen.dart';
import 'package:flutter/material.dart';

class chatscreen extends StatefulWidget {
  const chatscreen({super.key});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  // Dummy chat data
  List<ChatModel> chatList = [
    ChatModel(
      name: "Rohit",
      message: "See you at the meeting",
      image: "assets/images/image.png",
      isOnline: true,
    ),
    ChatModel(
      name: "Divya",
      message: "Hello !",
      image: "assets/users/divya.png",
      isOnline: true,
    ),
    ChatModel(
      name: "Monu",
      message: "Hey, how's it going?",
      image: "assets/users/monu.png",
      isOnline: false,
    ),
    ChatModel(
      name: "Family",
      message: "Photo",
      image: "assets/users/family.png",
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Message (${chatList.length.toString().padLeft(2, '0')})",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(chat.image),
                ),
                title: Text(
                  chat.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  chat.message,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                trailing: chat.isOnline
                    ? const Icon(Icons.circle, color: Colors.green, size: 14)
                    : null,

                // 👇 Navigate to ChatDetailScreen on tap
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(
                        name: chat.name,
                        image: chat.image,
                      ),
                    ),
                  );
                },
              ),
              Divider(height: 1, color: Colors.grey.shade300),
            ],
          );
        },
      ),
    );
  }
}
