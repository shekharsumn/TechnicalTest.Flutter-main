import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tech_task/presentation/widgets/save_post_button.dart';
import '../../helpers/test_helpers.dart';

void main() {
  group('SavePostButton', () {
    testWidgets('renders an IconButton widget', (WidgetTester tester) async {
      final mockPost = TestHelpers.createMockPost();
      
      await TestHelpers.pumpAndSettle(
        tester,
        TestHelpers.createTestApp(
          child: SavePostButton(post: mockPost),
        ),
      );

      // Should render an IconButton
      expect(find.byType(IconButton), findsOneWidget);
      
      // Should render one of the bookmark icons (either border or filled)
      expect(
        find.byIcon(Icons.bookmark_border).evaluate().isNotEmpty || 
        find.byIcon(Icons.bookmark).evaluate().isNotEmpty, 
        isTrue
      );
    });

    testWidgets('responds to tap', (WidgetTester tester) async {
      final mockPost = TestHelpers.createMockPost();
      
      await TestHelpers.pumpAndSettle(
        tester,
        TestHelpers.createTestApp(
          child: SavePostButton(post: mockPost),
        ),
      );

      // Find and tap the IconButton
      final iconButton = find.byType(IconButton);
      expect(iconButton, findsOneWidget);
      
      await tester.tap(iconButton);
      await tester.pump();
      
      // The tap should not throw an error
      // State changes are handled by the provider, so we just verify the tap works
    });

    testWidgets('creates widget with required post parameter', (WidgetTester tester) async {
      final mockPost = TestHelpers.createMockPost(id: 123, title: 'Test Post');
      
      await TestHelpers.pumpAndSettle(
        tester,
        TestHelpers.createTestApp(
          child: SavePostButton(post: mockPost),
        ),
      );

      // Widget should be created successfully
      expect(find.byType(SavePostButton), findsOneWidget);
    });
  });
}