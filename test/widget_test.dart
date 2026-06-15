import 'package:flutter_test/flutter_test.dart';

import 'package:quran_app/main.dart';

void main() {
  testWidgets('QuranApp shows splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const QuranApp());

    expect(find.text('تلاوات القرآن الكريم'), findsOneWidget);
    expect(find.text('Sheikh Bandar Baleelah'), findsOneWidget);
  });
}
