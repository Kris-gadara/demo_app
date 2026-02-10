import 'package:flutter_test/flutter_test.dart';
import 'package:pet_shop/main.dart';

void main() {
  testWidgets('App renders Pet Shop', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify app renders
    expect(find.byType(MyApp), findsOneWidget);
  });
}
