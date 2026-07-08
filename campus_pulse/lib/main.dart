import 'package:flutter/material.dart';

void main() {
  runApp(const CampusPulseApp());
}

class CampusPulseApp extends StatelessWidget {
  const CampusPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Pulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F4EC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF006B5E),
          brightness: Brightness.light,
        ),
      ),
      home: const CampusArticlePage(),
    );
  }
}

class CampusArticlePage extends StatelessWidget {
  const CampusArticlePage({super.key});

  static const Color deepGreen = Color(0xFF006B5E);
  static const Color warmYellow = Color(0xFFF2B705);
  static const Color ink = Color(0xFF17211F);
  static const Color softInk = Color(0xFF66706C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Campus Pulse'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1517048676732-d65bc937f952?w=1000&q=80',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: deepGreen,
                        child: const Center(
                          child: Icon(
                          Icons.groups_2,
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.05),
                        Colors.black.withValues(alpha: 0.62),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  left: 20,
                  right: 20,
                  bottom: 22,
                  child: Text(
                    'Students Turn Ideas Into Real Apps',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      height: 1.08,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: warmYellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'MOBILE COMPUTING',
                          style: TextStyle(
                            color: ink,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'GCTU - ENCE 216',
                        style: TextStyle(
                          color: softInk,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'A fresh wave of student projects is showing how simple mobile apps can solve everyday problems on campus.',
                    style: TextStyle(
                      color: ink,
                      fontSize: 20,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'SUMMARY',
                    style: TextStyle(
                      color: deepGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Mobile computing is not only about writing code. It is about noticing a problem, designing a clear screen, and helping people complete a task quickly. With Flutter, one codebase can produce apps for Android, web, desktop and more.',
                    style: TextStyle(color: ink, fontSize: 16, height: 1.55),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5DED0)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: warmYellow),
                            SizedBox(width: 8),
                            Text(
                              'MY TAKE',
                              style: TextStyle(
                                color: deepGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'A good student app should feel simple, fast and useful. My favorite idea is a campus helper app for announcements, class reminders and quick access to important school services.',
                          style: TextStyle(
                            color: ink,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'DID YOU KNOW?',
                    style: TextStyle(
                      color: deepGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Flutter uses widgets for almost everything on the screen. In this app, the page is mainly arranged with a Column, so each section appears from top to bottom.',
                    style: TextStyle(color: ink, fontSize: 16, height: 1.55),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
