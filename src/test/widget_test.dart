// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:src/provider/provider.dart';
import 'package:src/view/page/page.dart';

void main() {
  group('ui test', () {
    testWidgets('keyboard close test', (WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => RepositoryProvider()),
          ],
          builder: (context, _) {
            return const MaterialApp(home: HomePage());
          }));
      await tester.tap(find.byType(TextField));
      await tester.tap(find.byType(Scaffold));
      final BuildContext context = tester
          .element(find.byWidgetPredicate((widget) => widget is Scaffold));
      expect(MediaQuery.of(context).viewInsets.bottom, 0);
    });
  });
}
