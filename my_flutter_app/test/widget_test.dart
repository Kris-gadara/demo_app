import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_app/main.dart';

void main() {
  testWidgets('App renders TaskFlow title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify app renders the TaskFlow header
    expect(find.text('TaskFlow'), findsOneWidget);
  });
}
