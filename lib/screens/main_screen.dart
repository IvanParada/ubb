import 'package:animate_do/animate_do.dart';
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
        items: [
          BottomNavigationBarItem(
              icon: FadeInLeft(
                child: const Icon(
                  Icons.home_outlined,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Color.fromARGB(255, 8, 86, 100),
                      offset: Offset(2, 5),
                    )
                  ],
                ),
              ),
              activeIcon: BounceInDown(
                child: const Icon(
                  Icons.home,
                ),
              ),
              label: 'Home',
              tooltip: 'Home',
              backgroundColor: const Color(0xff1796AB)),
          BottomNavigationBarItem(
              icon: FadeInUp(
                child: const Icon(
                  Icons.map_outlined,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Color.fromARGB(255, 8, 86, 100),
                      offset: Offset(2, 5),
                    ),
                  ],
                ),
              ),
              activeIcon: BounceInDown(child: const Icon(Icons.map)),
              label: 'Mapa',
              tooltip: 'Mapa',
              backgroundColor: const Color(0xff1796AB)),
          BottomNavigationBarItem(
              icon: FadeInRight(
                child: const Icon(
                  Icons.settings_outlined,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Color.fromARGB(255, 8, 86, 100),
                      offset: Offset(2, 5),
                    )
                  ],
                ),
              ),
              activeIcon: BounceInDown(child: const Icon(Icons.settings)),
              label: 'Ajustes',
              tooltip: 'Ajustes',
              backgroundColor: const Color(0xff1796AB)),
        ],
      ),
    );
  }
}
