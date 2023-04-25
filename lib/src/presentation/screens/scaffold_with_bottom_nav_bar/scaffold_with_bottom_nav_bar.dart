import 'package:cinechase/src/presentation/screens/auth_screens/login_screen.dart';
import 'package:cinechase/src/presentation/screens/favourites_screen/favourites_screen.dart';
import 'package:cinechase/src/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key});

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: tabs,
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: const [
          HomeScreen(),
          LoginScreen(),
          FavouritesScreen(),
        ],
      ),
    );
  }
}

class ScaffoldWithNavBarTabItem extends NavigationDestination {
  const ScaffoldWithNavBarTabItem({
    super.key,
    required super.selectedIcon,
    required super.icon,
    required super.label,
    super.tooltip = '',
  });
}

final tabs = [
  const ScaffoldWithNavBarTabItem(
    selectedIcon: Icon(Icons.explore),
    icon: Icon(Icons.explore_outlined),
    label: 'Home',
  ),
  const ScaffoldWithNavBarTabItem(
    selectedIcon: Icon(Icons.person_3),
    icon: Icon(Icons.person_3_outlined),
    label: 'Profile',
  ),
  const ScaffoldWithNavBarTabItem(
    selectedIcon: Icon(Icons.favorite),
    icon: Icon(Icons.favorite_outline),
    label: 'Favourites',
  ),
];
