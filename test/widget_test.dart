import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadrescue/main.dart';

void main() {
  testWidgets('RoadRescue app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: RoadRescueApp(),
      ),
    );
    expect(find.byType(RoadRescueApp), findsOneWidget);
  });
}
