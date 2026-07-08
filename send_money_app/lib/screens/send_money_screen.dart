import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/screen_card.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    // Controllers should be disposed when the screen is removed.
    _amountController.dispose();
    super.dispose();
  }

  void _goToConfirmation() {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;

    // This improves the starter lab: invalid amounts stay on this screen.
    if (amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a valid amount')));
      return;
    }

    // The amount is passed as route data to the Confirmed screen.
    Navigator.pushNamed(context, '/confirm', arguments: amount);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenCard(
      icon: Icons.send,
      title: 'Send Money',
      subtitle: 'Type the amount you want to send.',
      buttonLabel: 'Continue',
      body: TextField(
        controller: _amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: 'Amount (GH₵)',
          prefixIcon: Icon(Icons.payments, color: kNavy),
          border: OutlineInputBorder(),
        ),
      ),
      onPressed: _goToConfirmation,
    );
  }
}
