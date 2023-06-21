import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            icon: FadeInLeft(child: const FaIcon(FontAwesomeIcons.house)),
            activeIcon: BounceInDown(
              child: const FaIcon(FontAwesomeIcons.house),
            ),
            label: 'Inicio',
            tooltip: 'Inicio',
            backgroundColor: const Color.fromARGB(255, 9, 27, 43),
          ),
          BottomNavigationBarItem(
            icon:
                FadeInUp(child: const FaIcon(FontAwesomeIcons.mapLocationDot)),
            activeIcon: BounceInDown(
                child: const FaIcon(FontAwesomeIcons.mapLocationDot)),
            label: 'Mapa',
            tooltip: 'Mapa',
            backgroundColor: const Color.fromARGB(255, 9, 27, 43),
          ),
          BottomNavigationBarItem(
            icon: FadeInRight(
              child: const FaIcon(FontAwesomeIcons.gear),
            ),
            activeIcon:
                BounceInDown(child: const FaIcon(FontAwesomeIcons.gear)),
            label: 'Ajustes',
            tooltip: 'Ajustes',
            backgroundColor: const Color.fromARGB(255, 9, 27, 43),
          ),
        ],
      ),
    );
  }
}
