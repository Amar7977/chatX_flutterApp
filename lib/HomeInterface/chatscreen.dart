import 'package:chatx/HomeInterface/ChatDetailScreen.dart';
import 'package:chatx/Widgets/info.dart';
import 'package:flutter/material.dart';

class chatscreen extends StatefulWidget {
  const chatscreen({super.key});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
          margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,

              ),

              child: Row(
                children: [
                  Text(
                    "Message (${info.length.toString().padLeft(2, '0')})",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            // Chat list
            Expanded(
              child: ListView.builder(
                itemCount: info.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    // Navigate to chat detail screen
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(
                            name: info[index]['name'].toString(),
                            profilePic: info[index]['profilePic'].toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  info[index]['profilePic'].toString(),
                                ),
                              ),
                              title: Text(
                                info[index]['name'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                info[index]['message'].toString(),
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                              trailing: info[index]['status'].toString() == 'true'
                                  ? const Icon(Icons.circle,
                                  color: Colors.green, size: 14)
                                  : null,
                            ),
                            Divider(height: 1, color: Colors.grey.shade300),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
