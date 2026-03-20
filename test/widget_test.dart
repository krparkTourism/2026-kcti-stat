import 'package:flutter_test/flutter_test.dart';
import 'package:kcti_stats/main.dart';

void main() {
  testWidgets('KCTI App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KctiApp());
    expect(find.byType(KctiApp), findsOneWidget);
  });
}
