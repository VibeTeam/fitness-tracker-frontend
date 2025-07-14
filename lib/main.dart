import 'package:fitness_tracker_frontend/screens/exercises.dart';
import 'package:fitness_tracker_frontend/screens/exercises_page.dart';
import 'package:fitness_tracker_frontend/screens/sign_in_page.dart';
import 'package:fitness_tracker_frontend/screens/sign_up_page.dart';
import '/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
      routes: {
        '/login': (context) => const SignInPage(),
        '/register': (context) => const SignUpPage(),
        '/main': (context) => const MainScreen(),
        '/exercises_group': (context) => const ExercisesGroupPage(),
      }
    );
  }
}
