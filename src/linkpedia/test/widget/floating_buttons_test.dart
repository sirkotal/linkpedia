import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkpedia/screens/wiki_page/floating_buttons.dart';

void main() {
  group('FloatingButtons', () {
    testWidgets('Open and close buttons', (WidgetTester tester) async {
      // title and url not needed because they are not used in the widget
      await tester.pumpWidget(
        MaterialApp(
          home: FloatingButtons(title: 'TestTitle', url: 'TestUrl', onTouch: () {})
        )
      );

      // button must be closed
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);
      expect(find.byIcon(Icons.comment), findsNothing);

      // open button
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pump();

      // button must be open
      expect(find.byIcon(Icons.more_horiz), findsNothing);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.comment), findsOneWidget);

      // close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      // button must be closed
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);
      expect(find.byIcon(Icons.comment), findsNothing);
    });
  });
}
