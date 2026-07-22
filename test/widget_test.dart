import 'package:flutter_test/flutter_test.dart';
import 'package:wms_mobile/main.dart';

void main() {
  testWidgets('App starts', (tester) async {
    await tester.pumpWidget(const WmsMobileApp());
    await tester.pump();
    expect(find.byType(WmsMobileApp), findsOneWidget);
  });
}
