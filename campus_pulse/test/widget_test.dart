import 'package:flutter_test/flutter_test.dart';
import 'package:campus_pulse/main.dart';

void main() {
  testWidgets('Campus Pulse article loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CampusPulseApp());

    expect(find.text('Campus Pulse'), findsOneWidget);
    expect(find.text('Students Turn Ideas Into Real Apps'), findsOneWidget);
    expect(find.text('SUMMARY'), findsOneWidget);
    expect(find.text('MY TAKE'), findsOneWidget);
    expect(find.text('DID YOU KNOW?'), findsOneWidget);
  });
}
