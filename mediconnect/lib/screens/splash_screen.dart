import 'package:flutter/material.dart';
import '../app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // initState runs once. After a short delay, replace Splash with Login.
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 52,
              backgroundColor: Colors.white,
              child: Icon(Icons.health_and_safety, size: 58, color: kPrimary),
            ),
            SizedBox(height: 24),
            Text(
              'MediConnect',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Care that meets you anywhere',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            SizedBox(height: 42),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
