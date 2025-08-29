import 'package:flutter/material.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  String coverImage =
      "https://images.unsplash.com/photo-1503264116251-35a269479413";
  String profileImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60';
  String userName = "Sanju Meena";
  String status = "Available";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Cover Image
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(coverImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Profile Image (overlay 50% outside cover)
              Positioned(
                bottom: -60, // half outside the cover
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 60), // space for the avatar
          // Name + Status
          Text(
            userName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(status, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 5),

          // Account Info
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    "Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.email_outlined),
                        ),
                        title: const Text("Email"),
                        subtitle: const Text("sanjumeena7039@gmail.com"),
                        onTap: () {
                          // Example action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Email clicked")),
                          );
                        },
                      ),

                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.phone_outlined),
                        ),
                        title: Text("Phone"),
                        subtitle: Text("+91 8450191722"),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Phone clicked")),
                          );
                        },
                      ),

                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.lock_outline),
                        ),
                        title: Text("Password"),
                        subtitle: Text("Change your password"),
                        onTap: () {
                          // Navigate to change password screen
                        },
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: true,
                        onChanged: (val) {},
                        title: const Text("Notifications"),
                        secondary: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.notifications_none),
                        ),
                      ),

                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.privacy_tip_outlined),
                        ),
                        title: Text("Privacy"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          //navigate to privacy screen
                        },
                      ),

                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.brightness_6_outlined),
                        ),

                        title: Text("Appearance"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          //navigate to dark & light theme screen
                        },
                      ),

                      ListTile(
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.help_outline),
                        ),
                        title: Text("Help"),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          //navigate to help screen
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
