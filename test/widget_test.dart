import 'package:flutter_test/flutter_test.dart';

import 'package:eng_evry/main.dart';

void main() {
  testWidgets('Home screen shows TOEIC and IELTS buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EngEvryApp());

    expect(find.text('Eng Evry'), findsOneWidget);
    expect(find.text('TOEIC'), findsOneWidget);
    expect(find.text('IELTS'), findsOneWidget);
  });
}
