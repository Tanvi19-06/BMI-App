import 'package:flutter/material.dart';
import 'onboarding_screen.dart'; // Import the file where OnboardingPage is defined
import 'home_screen.dart'; // Import the file where HomeScreen is defined

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingPage(), // Use OnboardingPage here
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
