import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('init tests', () {
    Future<void> _initOnlyApp(WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          title: 'EXERLOG',
          home: Container(
            child: const Text('EXERLOG'),
          ),
        ),);
      });
    }

    testWidgets('when init up home container', (WidgetTester tester) async {
      var homeContainer = find.text('EXERLOG');
      await _initOnlyApp(tester);
      await tester.pump();
      expect(homeContainer, findsOneWidget);
    });
  });
}
