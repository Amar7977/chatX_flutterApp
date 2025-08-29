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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: _screens[_selectedIndex],

      // Bottom Navigation Bar with custom icons
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:  Theme.of(context).colorScheme.tertiary,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/chaticon.png',
              height: 24,
              color: _selectedIndex == 0 ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.secondary,
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/contacticon.png',
              height: 28,
              color: _selectedIndex == 1 ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.secondary,
            ),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/logo/profileicon.png',
              height: 28,
              color: _selectedIndex == 2 ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.secondary,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
