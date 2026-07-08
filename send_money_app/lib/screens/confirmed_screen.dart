import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/screen_card.dart';

class ConfirmedScreen extends StatelessWidget {
  const ConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final amount = ModalRoute.of(context)?.settings.arguments as double? ?? 0;

    return ScreenCard(
      icon: Icons.check_circle,
      title: 'Confirmed',
      subtitle: 'Your transaction has been recorded.',
      buttonLabel: 'Done',
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kPageBackground,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          'Thank you! You sent GH₵ ${amount.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kNavy,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
        ),
      ),
      // popUntil removes screens until Home is the only route left.
      onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
    );
  }
}
