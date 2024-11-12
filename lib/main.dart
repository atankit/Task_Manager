import 'package:flutter/material.dart';
import 'package:task_manager/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final gfont = 'Poppins';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: gfont,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
