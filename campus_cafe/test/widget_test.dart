import 'package:flutter_test/flutter_test.dart';
import 'package:campus_cafe/main.dart';

void main() {
  testWidgets('Campus Cafe starts with an empty order', (tester) async {
    await tester.pumpWidget(const CampusCafeApp());

    expect(find.text('Campus Cafe'), findsOneWidget);
    expect(find.text('0 items'), findsOneWidget);
    expect(find.text('GHS 0.00'), findsOneWidget);
  });
}
