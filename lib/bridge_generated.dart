// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.78.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:ffi' as ffi;

abstract class TrustchainFfi {
  /// Creates a controlled DID from a passed document state, writing the associated create operation to file in the operations path.
  Future<String> create(
      {String? docState, required bool verbose, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kCreateConstMeta;

  /// An uDID attests to a dDID, writing the associated update operation to file in the operations path.
  Future<void> attest(
      {required String did,
      required String controlledDid,
      required bool verbose,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kAttestConstMeta;

  /// Resolves a given DID using a resolver available at "ion_endpoint"
  Future<String> resolve({required String did, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kResolveConstMeta;

  /// TODO: the below have no CLI implementation currently but are planned
  /// Verifies a given DID using a resolver available at localhost:3000, returning a result.
  Future<String> verify({required String did, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kVerifyConstMeta;

  Future<String> vcSign(
      {required String serialCredential,
      required String did,
      String? keyId,
      dynamic hint});

  FlutterRustBridgeTaskConstMeta get kVcSignConstMeta;
}

class TrustchainFfiImpl implements TrustchainFfi {
  final TrustchainFfiPlatform _platform;
  factory TrustchainFfiImpl(ExternalLibrary dylib) =>
      TrustchainFfiImpl.raw(TrustchainFfiPlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory TrustchainFfiImpl.wasm(FutureOr<WasmModule> module) =>
      TrustchainFfiImpl(module as ExternalLibrary);
  TrustchainFfiImpl.raw(this._platform);
  Future<String> create(
      {String? docState, required bool verbose, dynamic hint}) {
    var arg0 = _platform.api2wire_opt_String(docState);
    var arg1 = verbose;
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_create(port_, arg0, arg1),
      parseSuccessData: _wire2api_String,
      constMeta: kCreateConstMeta,
      argValues: [docState, verbose],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kCreateConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "create",
        argNames: ["docState", "verbose"],
      );

  Future<void> attest(
      {required String did,
      required String controlledDid,
      required bool verbose,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(did);
    var arg1 = _platform.api2wire_String(controlledDid);
    var arg2 = verbose;
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_attest(port_, arg0, arg1, arg2),
      parseSuccessData: _wire2api_unit,
      constMeta: kAttestConstMeta,
      argValues: [did, controlledDid, verbose],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kAttestConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "attest",
        argNames: ["did", "controlledDid", "verbose"],
      );

  Future<String> resolve({required String did, dynamic hint}) {
    var arg0 = _platform.api2wire_String(did);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_resolve(port_, arg0),
      parseSuccessData: _wire2api_String,
      constMeta: kResolveConstMeta,
      argValues: [did],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kResolveConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "resolve",
        argNames: ["did"],
      );

  Future<String> verify({required String did, dynamic hint}) {
    var arg0 = _platform.api2wire_String(did);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_verify(port_, arg0),
      parseSuccessData: _wire2api_String,
      constMeta: kVerifyConstMeta,
      argValues: [did],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kVerifyConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "verify",
        argNames: ["did"],
      );

  Future<String> vcSign(
      {required String serialCredential,
      required String did,
      String? keyId,
      dynamic hint}) {
    var arg0 = _platform.api2wire_String(serialCredential);
    var arg1 = _platform.api2wire_String(did);
    var arg2 = _platform.api2wire_opt_String(keyId);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_vc_sign(port_, arg0, arg1, arg2),
      parseSuccessData: _wire2api_String,
      constMeta: kVcSignConstMeta,
      argValues: [serialCredential, did, keyId],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kVcSignConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "vc_sign",
        argNames: ["serialCredential", "did", "keyId"],
      );

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  String _wire2api_String(dynamic raw) {
    return raw as String;
  }

  int _wire2api_u8(dynamic raw) {
    return raw as int;
  }

  Uint8List _wire2api_uint_8_list(dynamic raw) {
    return raw as Uint8List;
  }

  void _wire2api_unit(dynamic raw) {
    return;
  }
}

// Section: api2wire

@protected
bool api2wire_bool(bool raw) {
  return raw;
}

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer

class TrustchainFfiPlatform extends FlutterRustBridgeBase<TrustchainFfiWire> {
  TrustchainFfiPlatform(ffi.DynamicLibrary dylib)
      : super(TrustchainFfiWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_opt_String(String? raw) {
    return raw == null ? ffi.nullptr : api2wire_String(raw);
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

// Section: api_fill_to_wire
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class TrustchainFfiWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  TrustchainFfiWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  TrustchainFfiWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_create(
    int port_,
    ffi.Pointer<wire_uint_8_list> doc_state,
    bool verbose,
  ) {
    return _wire_create(
      port_,
      doc_state,
      verbose,
    );
  }

  late final _wire_createPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_uint_8_list>,
              ffi.Bool)>>('wire_create');
  late final _wire_create = _wire_createPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>, bool)>();

  void wire_attest(
    int port_,
    ffi.Pointer<wire_uint_8_list> did,
    ffi.Pointer<wire_uint_8_list> controlled_did,
    bool verbose,
  ) {
    return _wire_attest(
      port_,
      did,
      controlled_did,
      verbose,
    );
  }

  late final _wire_attestPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>, ffi.Bool)>>('wire_attest');
  late final _wire_attest = _wire_attestPtr.asFunction<
      void Function(int, ffi.Pointer<wire_uint_8_list>,
          ffi.Pointer<wire_uint_8_list>, bool)>();

  void wire_resolve(
    int port_,
    ffi.Pointer<wire_uint_8_list> did,
  ) {
    return _wire_resolve(
      port_,
      did,
    );
  }

  late final _wire_resolvePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>('wire_resolve');
  late final _wire_resolve = _wire_resolvePtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_verify(
    int port_,
    ffi.Pointer<wire_uint_8_list> did,
  ) {
    return _wire_verify(
      port_,
      did,
    );
  }

  late final _wire_verifyPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, ffi.Pointer<wire_uint_8_list>)>>('wire_verify');
  late final _wire_verify = _wire_verifyPtr
      .asFunction<void Function(int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_vc_sign(
    int port_,
    ffi.Pointer<wire_uint_8_list> serial_credential,
    ffi.Pointer<wire_uint_8_list> did,
    ffi.Pointer<wire_uint_8_list> key_id,
  ) {
    return _wire_vc_sign(
      port_,
      serial_credential,
      did,
      key_id,
    );
  }

  late final _wire_vc_signPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<wire_uint_8_list>)>>('wire_vc_sign');
  late final _wire_vc_sign = _wire_vc_signPtr.asFunction<
      void Function(int, ffi.Pointer<wire_uint_8_list>,
          ffi.Pointer<wire_uint_8_list>, ffi.Pointer<wire_uint_8_list>)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

final class _Dart_Handle extends ffi.Opaque {}

final class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<
        ffi.Bool Function(DartPort port_id, ffi.Pointer<ffi.Void> message)>>;
typedef DartPort = ffi.Int64;
