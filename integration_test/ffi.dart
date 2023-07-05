import 'package:test/test.dart';
import 'dart:io';
import 'dart:convert';
import 'package:trustchain_dart/trustchain_dart.dart';
import 'package:trustchain_gui/ffi.dart';

final didExample =
    jsonDecode(File('test/data/did_example.json').readAsStringSync());

void ffiTest() {
  group('ffi api', () {
    test('resolve did over ffi', () async {
      final did = DIDModel.fromMap(didExample);
      final resolvedDid = await api.resolve(did: did.did);
    
      expect(
          DIDModel.fromMap(jsonDecode(resolvedDid)),
          equals(did));
    });

  });
}
