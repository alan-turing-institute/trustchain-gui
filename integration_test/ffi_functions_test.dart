// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustchain_gui/credible_imports/trustchain_widgets/document.dart';
import 'package:trustchain_gui/ffi.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trustchain_gui/main.dart' as app;
import 'dart:io';
import 'dart:convert';
import 'package:trustchain_dart/trustchain_dart.dart';

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  print(Directory.current);
  print(String.fromEnvironment("TRUSTCHAIN_DATA"));

  // final didExample = jsonDecode(File('./data/did_example.json').readAsStringSync());

  group('test each ffi function', () {
    testWidgets('resolve did', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final resolvedDid = await api.resolve(
          did: "did:ion:test:EiAtHHKFJWAk5AsM3tgCut3OiBY4ekHTf66AAjoysXL65Q"
        );
      print(resolvedDid);
    }, tags: 'requires-ion-server');

    testWidgets('create did', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final fileName = await api.create(
        verbose: true,
        docState: 
        '''
{
  "services": [
    {
      "id": "12345",
      "type": "6789101112",
      "serviceEndpoint": "https://testendpointnameeasytospotlater.com"
    }
    
  ]
}
        ''');
      File file = await Storage.readTrustchainOperation(fileName);
      final createdDid = jsonDecode(file.readAsStringSync());
      print(createdDid);
    });

    testWidgets('verify did', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final verifiedChain = await api.verify(
          did: "did:ion:test:EiAtHHKFJWAk5AsM3tgCut3OiBY4ekHTf66AAjoysXL65Q"
        );
      print(verifiedChain);
    }, tags: 'requires-ion-server');

    testWidgets('sign vc', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final signedVc = await api.vcSign(
          serialCredential: '''
{
   "@context" : [
      "https://www.w3.org/2018/credentials/v1",
      "https://schema.org/"
   ],
   "credentialSubject" : {
      "address" : {
         "addressCountry" : "UK",
         "addressLocality" : "London",
         "postalCode" : "SE1 3WY",
         "streetAddress" : "10 Main Street"
      },
      "birthDate" : "1989-03-15",
      "name" : "J. Doe"
   },
   "id" : "http://example.edu/credentials/332",
   "issuanceDate" : "2020-08-19T21:41:50Z",
   "issuer" : "did:key:z6MkpbgE27YYYpSF8hd7ipazeJxiUGMEzQFT5EgN46TDwAeU",
   "type" : [
      "VerifiableCredential",
      "IdentityCredential"
   ]
}
          ''',
          did: "did:ion:test:EiAtHHKFJWAk5AsM3tgCut3OiBY4ekHTf66AAjoysXL65Q"
        );
      print(signedVc);
    }, tags: 'requires-ion-server');



  });
}


