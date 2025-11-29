import 'package:datingapp/screens/onboarding_screen.dart';
import 'package:datingapp/screens/otp/otp_page.dart';
import 'package:datingapp/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // inside MaterialApp.routes or push manually
      routes: {
        '/otp': (_) => const OtpPage(),
        '/nextPage': (_) => const ProfileScreen(),
      },
      title: 'Dating App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: OnboardingScreen(title: 'Dating App'),
      debugShowCheckedModeBanner: false,
    );
  }
}
