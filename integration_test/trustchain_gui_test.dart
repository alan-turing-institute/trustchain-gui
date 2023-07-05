// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustchain_gui/ffi.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trustchain_gui/main.dart' as app;
import 'dart:io';
import 'dart:convert';
import 'package:trustchain_dart/trustchain_dart.dart';

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  print('integration_test/main.dart starts!');
  final didExample = jsonDecode(File('test/data/did_example.json').readAsStringSync());

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final did = DIDModel.fromMap(didExample);
    final resolvedDid = await api.resolve(did: did.did);
    print(DIDModel.fromMap(jsonDecode(resolvedDid)).did);
    
    expect(
        DIDModel.fromMap(jsonDecode(resolvedDid)),
        equals(did));
  });
}


// import 'ffi.dart';

// void main() {
//   ffiTest();
// }
