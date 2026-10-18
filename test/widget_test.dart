// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:hospital_on_wheels/main.dart';

void main() {
  testWidgets('home page shows the Mukono hospital location', (WidgetTester tester) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    await tester.pumpWidget(const HospitalOnWheelsApp());
    await tester.pumpAndSettle();

    expect(find.text('Hospital on Wheels'), findsWidgets);
    expect(find.text('Access care with complete confidence.'), findsOneWidget);
    expect(find.textContaining('Lands Office'), findsWidgets);
  });
}
