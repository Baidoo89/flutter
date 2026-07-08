import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mediconnect/main.dart';

void main() {
  testWidgets('MediConnect login and chat flow works', (tester) async {
    await tester.pumpWidget(const MediConnectApp());

    expect(find.text('MediConnect'), findsOneWidget);

    // Move past the splash timer without waiting on endless loading animation.
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.enterText(
      find.byType(EditableText).at(0),
      'student@gctu.edu.gh',
    );
    await tester.enterText(find.byType(EditableText).at(1), 'secret123');
    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Available Doctors'), findsOneWidget);
    final kofiTile = find.ancestor(
      of: find.text('Dr. Kofi Asante'),
      matching: find.byType(ListTile),
    );
    expect(kofiTile, findsOneWidget);
    await tester.ensureVisible(kofiTile);
    await tester.tap(kofiTile);
    await tester.pumpAndSettle();

    expect(find.text('Dr. Kofi Asante'), findsOneWidget);
    expect(find.text('Cardiologist - Online'), findsOneWidget);
    await tester.enterText(find.byType(EditableText).last, 'I have a headache');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();
    expect(find.text('I have a headache'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1400));
    expect(
      find.text('Thanks for explaining. How long have you felt this way?'),
      findsOneWidget,
    );
  });
}
