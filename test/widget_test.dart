import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:litshelf2/main.dart';

void main() {
  // Ensures widget binding is initialized before tests run
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Make sure Firebase is initialized
    await Firebase.initializeApp();
  });

  testWidgets('MyApp builds and shows initial screen', (WidgetTester tester) async {
    // 🟢 Provide the required isLoggedIn parameter!
    await tester.pumpWidget(MyApp(isLoggedIn: false));

    // Check MaterialApp exists
    expect(find.byType(MaterialApp), findsOneWidget);

    // OPTIONAL: If your LoginPage has text like 'Login'
    // expect(find.text('Login'), findsOneWidget);
  });
}
