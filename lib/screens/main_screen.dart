import 'package:flutter/material.dart';
import 'package:ubb/screens/screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const LoadingScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Color.fromARGB(255, 8, 86, 100),
                    offset: Offset(2, 5),
                  )
                ],
              ),
              activeIcon: Icon(
                Icons.home,
              ),
              label: 'Home',
              backgroundColor: Color(0xff1796AB)),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map_outlined,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Color.fromARGB(255, 8, 86, 100),
                    offset: Offset(2, 5),
                  ),
                ],
              ),
              activeIcon: Icon(Icons.map),
              label: 'Maps',
              backgroundColor: Color(0xff1796AB)),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Color.fromARGB(255, 8, 86, 100),
                    offset: Offset(2, 5),
                  )
                ],
              ),
              activeIcon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Color(0xff1796AB)),
        ],
      ),
    );
  }
}
