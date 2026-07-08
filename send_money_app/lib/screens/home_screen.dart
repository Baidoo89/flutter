import 'package:flutter/material.dart';
import '../widgets/screen_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenCard(
      icon: Icons.account_balance_wallet,
      title: 'SendMoney',
      subtitle: 'A simple mobile money demo using named routes.',
      buttonLabel: 'Start Transfer',
      // pushNamed adds the Send Money screen on top of the Navigator stack.
      onPressed: () => Navigator.pushNamed(context, '/send'),
    );
  }
}
