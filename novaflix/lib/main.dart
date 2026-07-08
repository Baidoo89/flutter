import 'package:flutter/material.dart';
import 'models/movie.dart';
import 'screens/browse_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/login_screen.dart';
import 'screens/player_screen.dart';
import 'screens/register_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const NovaFlixApp());

class NovaFlixApp extends StatelessWidget {
  const NovaFlixApp({super.key});

  static const Color novaRed = Color(0xFFE11D48);
  static const Color novaBlack = Color(0xFF101010);
  static const Color panel = Color(0xFF18181B);
  static const Color muted = Color(0xFFA1A1AA);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaFlix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: novaBlack,
        colorScheme: ColorScheme.fromSeed(
          seedColor: novaRed,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: panel,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: novaRed,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/browse': (context) => const BrowseScreen(),
      },
      // Routes that need typed data are built here, in one central place.
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (context) => DetailScreen(movie: movie),
            settings: settings,
          );
        }
        if (settings.name == '/player') {
          final movie = settings.arguments as Movie;
          return MaterialPageRoute(
            builder: (context) => PlayerScreen(movie: movie),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
