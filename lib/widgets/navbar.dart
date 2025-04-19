import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Navbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      showUnselectedLabels: true, // Show labels for inactive tabs
      type: BottomNavigationBarType.fixed, // Ensure all items are visible
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 24), // Adjust icon size
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart, size: 24),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer, size: 24),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: 24),
          label: 'Settings',
        ),
      ],
    );
  }
}
