import 'package:cinechase/src/presentation/screens/discover_screen/discover_screen.dart';
import 'package:cinechase/src/presentation/screens/profile_screen/profile_screen.dart';
import 'package:cinechase/src/presentation/screens/favourites_screen/favourites_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Discover',
              tooltip: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline_outlined),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favourites',
              tooltip: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_2_outlined),
              selectedIcon: Icon(Icons.person_2),
              label: 'Profile',
              tooltip: '',
            ),
          ]),
      body: <Widget>[
        const DiscoverScreen(),
        const FavouritesScreen(),
        const ProfileScreen(),
      ][currentPageIndex],
    );
  }
}
