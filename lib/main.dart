import 'package:cinechase/src/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinechase/src/presentation/screens/home_screen/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group project',
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
