import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ubb/screens/screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final screens = [
    const HomeScreen(),
    const MapsOptionsScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: CurvedNavigationBar(
          index: selectedIndex,
          height: 60,
          items: [
            _builNavItem(Icons.home, selectedIndex == 0),
            _builNavItem(Icons.map, selectedIndex == 1),
            _builNavItem(Icons.settings, selectedIndex == 1),
          ],
          color: const Color.fromARGB(255, 9, 27, 43),
          buttonBackgroundColor: const Color.fromARGB(255, 9, 27, 43),
          backgroundColor: Colors.grey.shade300,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          }),
    );
  }

  Widget _builNavItem(IconData icon, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Icon(
        icon,
        size: 30,
        color: isSelected ? const Color(0xFFD3DDDF) : Colors.white,
      ),
    );
  }
}
