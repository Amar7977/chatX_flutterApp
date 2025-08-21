import 'package:chatx/HomeInterface/chatscreen.dart';
import 'package:chatx/HomeInterface/contactscreen.dart';
import 'package:chatx/HomeInterface/profilescreen.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _selectedIndex = 0;

  // Screens list
  final List<Widget> _screens = [
    chatscreen(),
    contactscreen(),
    profilescreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: _screens[_selectedIndex],

      // Bottom Navigation Bar with custom icons
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/chaticon.png',
              height: 24,
              color: _selectedIndex == 0 ? Colors.black : Colors.grey,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/contacticon.png',
              height: 28,
              color: _selectedIndex == 1 ? Colors.black : Colors.grey,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/profileicon.png',
              height: 28,
              color: _selectedIndex == 2 ? Colors.black : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
