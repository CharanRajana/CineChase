import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project32/src/core/router.dart';

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
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: 'Group project',
          darkTheme: ThemeData(
              fontFamily: GoogleFonts.merriweather().fontFamily,
              useMaterial3: true,
              appBarTheme: const AppBarTheme(color: Colors.transparent),
              scaffoldBackgroundColor: Colors.black,
              colorScheme: darkDynamic ??
                  ColorScheme.fromSeed(
                    seedColor: Colors.red.shade700,
                    brightness: Brightness.dark,
                  )),
          themeMode: ThemeMode.dark,
        );
      },
    );
  }
}
