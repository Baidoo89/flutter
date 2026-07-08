C// ============================================================
//  ENCE 216 - Mobile Computing
//  Simple News App in Flutter (built with a Column)
//  Ghana Communication Technology University (GCTU)
//
//  This is the FINISHED app. In class we build it up
//  step by step, starting with coloured placeholder cards
//  and then filling each card with real content.
//  Put this code in:  lib/main.dart
// ============================================================

import 'package:flutter/material.dart';

// 1) The entry point. Every Flutter app starts at main().
//    runApp() takes ONE widget and puts it on the screen.
void main() {
  runApp(const NewsApp());
}

// 2) The root widget of the whole app.
//    It is "Stateless" because nothing on this screen changes
//    by itself (no buttons, counters, etc.).
class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp wraps our app and gives us themes,
    // navigation and the Material Design look.
    return MaterialApp(
      title: 'Simple News App',
      debugShowCheckedModeBanner: false, // hides the red DEBUG ribbon
      theme: ThemeData(
        primaryColor: const Color(0xFF002060), // GCTU navy
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const NewsArticlePage(),
    );
  }
}

// 3) The single page (screen) of our news app.
class NewsArticlePage extends StatelessWidget {
  const NewsArticlePage({super.key});

  // Our brand colours, kept in one place so they are easy to reuse.
  static const Color navy = Color(0xFF002060);   // GCTU navy
  static const Color amber = Color(0xFFD4A017);  // GCTU amber/gold
  static const Color greyText = Color(0xFF6B6B6B);

  @override
  Widget build(BuildContext context) {
    // Scaffold is the skeleton of a screen:
    // it gives us an AppBar (top bar) and a body.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Daily News'),
      ),

      // SingleChildScrollView lets the page scroll.
      // A plain Column that is taller than the screen would
      // throw the yellow-and-black "overflow" warning, so we
      // wrap it so the user can scroll down.
      body: SingleChildScrollView(
        // A Column stacks its children VERTICALLY, top to bottom.
        child: Column(
          // Push everything to the LEFT edge.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- CARD 1: HEADER IMAGE ----------
            // We start with a coloured Container as a placeholder,
            // then drop a real image on top of it.
            Container(
              height: 220,
              width: double.infinity, // stretch full width
              color: navy,            // shows while the image loads / if offline
              child: Image.network(
                'https://images.unsplash.com/photo-1490806843957-31f4c9a91c65?w=900&q=80',
                fit: BoxFit.cover,
                // If there is no internet, fall back to a friendly placeholder.
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.landscape, color: Colors.white, size: 64),
                  );
                },
              ),
            ),

            // ---------- CARD 2: TEXT CONTENT ----------
            // Padding adds space around the text so it does not
            // touch the edges of the screen.
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- Title --
                  const Text(
                    'MOUNT FUJI',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: navy,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // -- Amber subtitle --
                  const Text(
                    'DAY 1:  9AM - 1:30PM',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: amber,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // -- Muted caption --
                  const Text(
                    'STANDARD PACKAGE',
                    style: TextStyle(
                      fontSize: 11,
                      color: greyText,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 26),

                  // -- SUMMARY section --
                  const Text(
                    'SUMMARY',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "It's considered one of Japan's 3 sacred mountains, "
                    'and summit hikes remain a popular activity. Its iconic '
                    'profile is the subject of numerous works of art, notably '
                    'Edo Period prints by Hokusai and Hiroshige.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5, // line spacing for easy reading
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 26),

                  // -- DID YOU KNOW section --
                  const Text(
                    'DID YOU KNOW',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'There are three cities that surround Mount Fuji: '
                    'Gotemba, Fujiyoshida and Fujinomiya.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black87,
                    ),
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