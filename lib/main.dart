import 'package:flutter/material.dart';
import 'package:flashcabs/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const CurrentLocationScreen(),
    );
  }
}

