import 'package:flutter_test/flutter_test.dart';
import 'package:quran_app/core/di/injection_container.dart';
import 'package:quran_app/main.dart';

void main() {
  setUp(() async {
    await initDependencies();
  });

  testWidgets('QuranApp shows splash page', (WidgetTester tester) async {
    await tester.pumpWidget(const QuranApp());

    expect(find.text('Sheikh Bandar Baleelah'), findsOneWidget);
  });
}
