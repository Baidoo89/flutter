import 'package:flutter/material.dart';
import 'screens/confirmed_screen.dart';
import 'screens/home_screen.dart';
import 'screens/send_money_screen.dart';
import 'theme.dart';

void main() {
  runApp(const SendMoneyApp());
}

class SendMoneyApp extends StatelessWidget {
  const SendMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Money App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kNavy,
        colorScheme: ColorScheme.fromSeed(seedColor: kNavy),
      ),
      // Named routes keep navigation organized in one route table.
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/send': (context) => const SendMoneyScreen(),
        '/confirm': (context) => const ConfirmedScreen(),
      },
    );
  }
}
