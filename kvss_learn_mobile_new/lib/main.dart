import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/register_screen.dart';
import 'screens/lessons_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn With AI',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // 👈 Starts here
      routes: {
        '/splash': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) =>   const HomeScreen(userEmail: 'User'),
  '/lessons': (context) => const LessonsScreen(),
      },
    );
  }
}
