import 'package:flutter/material.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Replace the splash after the delay so the back button never returns here.
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: NovaFlixApp.novaBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NOVAFLIX',
              style: TextStyle(
                color: NovaFlixApp.novaRed,
                fontSize: 46,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'STREAM STORIES THAT MOVE',
              style: TextStyle(
                color: NovaFlixApp.muted,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 42),
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                color: NovaFlixApp.novaRed,
                backgroundColor: NovaFlixApp.panel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
