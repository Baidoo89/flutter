import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novaflix/main.dart';

void main() {
  testWidgets('NovaFlix login, detail, and player flow works', (tester) async {
    await tester.pumpWidget(const NovaFlixApp());

    expect(find.text('NOVAFLIX'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Sign in'), findsOneWidget);

    await tester.enterText(
      find.byType(EditableText).at(0),
      'viewer@gctu.edu.gh',
    );
    await tester.enterText(find.byType(EditableText).at(1), 'secret123');
    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Trending Now'), findsOneWidget);
    await tester.tap(find.text('ACCRA AFTER DARK').first);
    await tester.pumpAndSettle();

    expect(find.text('Accra After Dark'), findsWidgets);
    expect(find.textContaining('98% Match'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Play'));
    await tester.pumpAndSettle();
    expect(find.text('Now Playing: Accra After Dark'), findsOneWidget);
  });
}
