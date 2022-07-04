import 'package:flutter/material.dart';
import 'package:project32/extras/theme.dart';
import 'package:project32/screens/about.dart';
import 'package:project32/screens/homepage.dart';
import 'package:project32/screens/page_not_found.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group project',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.red,
        textTheme: myTextTheme,
      ),
      initialRoute: '/',
      routes: {
        '/404': (context) => const PageNotFound(),
        '/about': (context) => const About(),
      },
      home: const Homepage(),
    );
  }
}
