import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/main.dart';

void main() {
  testWidgets('SendMoney flow validates and confirms amount', (tester) async {
    await tester.pumpWidget(const SendMoneyApp());

    expect(find.text('SendMoney'), findsOneWidget);

    await tester.tap(find.text('Start Transfer'));
    await tester.pumpAndSettle();
    expect(find.text('Send Money'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pump();
    expect(find.text('Enter a valid amount'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '75.5');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Thank you! You sent GH₵ 75.50'), findsOneWidget);

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.text('SendMoney'), findsOneWidget);
  });
}
