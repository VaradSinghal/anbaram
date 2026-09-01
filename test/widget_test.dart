import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:anbaram_admin/app.dart';

void main() {
  testWidgets('App renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: AnbaramApp()),
    );

    // The splash screen should show the Anbaram title
    expect(find.text('Anbaram'), findsOneWidget);
  });
}
