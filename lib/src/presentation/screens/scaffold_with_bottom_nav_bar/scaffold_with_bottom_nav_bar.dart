import 'package:cinechase/src/presentation/screens/home_screen/home_screen.dart';
import 'package:cinechase/src/presentation/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:navigator_scope/navigator_scope.dart';

import '../watchlist_screen/watchlist_screen.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key});

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int currentTab = 0;

  final tabs = const [
    NavigationDestination(
      icon: Icon(Icons.explore_outlined),
      selectedIcon: Icon(Icons.explore),
      label: 'Discover',
      tooltip: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      selectedIcon: Icon(Icons.person_2),
      label: 'Profile',
      tooltip: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.bookmark_outline),
      selectedIcon: Icon(Icons.bookmark),
      label: 'WatchList',
      tooltip: '',
    ),
  ];

  final navigatorKeys = [
    GlobalKey<NavigatorState>(debugLabel: 'Home Tab'),
    GlobalKey<NavigatorState>(debugLabel: 'Profile Tab'),
    GlobalKey<NavigatorState>(debugLabel: 'WatchList Tab'),
  ];

  NavigatorState get currentNavigator =>
      navigatorKeys[currentTab].currentState!;

  void onTabSelected(int tab) {
    if (tab == currentTab && currentNavigator.canPop()) {
      currentNavigator.popUntil((route) => route.isFirst);
    } else {
      setState(() => currentTab = tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = NavigatorScope(
      currentDestination: currentTab,
      destinationCount: tabs.length,
      destinationBuilder: (context, index) {
        return NestedNavigator(
          navigatorKey: navigatorKeys[index],
          builder: (context) => IndexedStack(
            index: index,
            children: const [
              HomeScreen(),
              ProfileScreen(),
              WatchListScreen(),
            ],
          ),
        );
      },
    );

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentTab,
        destinations: tabs,
        onDestinationSelected: onTabSelected,
      ),
      body: body,
    );
  }
}
