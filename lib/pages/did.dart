import 'dart:convert';
import 'dart:io';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:trustchain_gui/credible_imports/credible_shared_widget/base/button.dart';
import 'package:trustchain_dart/trustchain_dart.dart';
import 'package:trustchain_gui/credible_imports/trustchain_widgets/document.dart';
import 'package:trustchain_gui/ffi.dart';
import 'package:trustchain_gui/ui/ui.dart';

class _DIDPageState extends State<DIDPage> {
  final resolveInputCtrl = TextEditingController();
  final createInputCtrl = TextEditingController();
  final attestDidInputCtrl = TextEditingController();
  final attestControlledDidInputCtrl = TextEditingController();
  final verifyDIDInputCtrl = TextEditingController();

  String? resolvedDid;
  final resolveInputError = ValueNotifier<String?>(null);

  final createdDid = ValueNotifier<String?>(null);
  final createInputError = ValueNotifier<String?>(null);

  final attestInputError = ValueNotifier<String?>(null);

  final verifiedChain = ValueNotifier<String?>(null);
  final verifyInputError = ValueNotifier<String?>(null);

  void doResolve() async {
    resolveInputError.value = null;
    try {
      var did = await api.resolve(did: resolveInputCtrl.text);
      setState(() {
        resolvedDid = did;
      });
    } on FfiException catch(e) {
      var err = FfiError.parseFfiError(e);
      print("${err.varient.code}: ${err.info}");
      switch (err.varient) {
        case FfiError.failedToResolveDID:
          resolveInputError.value = "Resolve Error: ${err.info}";
          break;
        default:
          resolveInputError.value = "Unexpected Error: ${err.info}";
      }
    } catch (e) {
      rethrow;  // rethrow the error if it originates from dart rather than the ffi
    }
  }

  void doCreate() async {
    createInputError.value = null;
    var docState = createInputCtrl.text;
    String fileName;
    try {
      if (docState.isNotEmpty) {
        fileName = await api.create(verbose: true, docState: docState);
      } else {
        fileName = await api.create(verbose: true);
      }

      File file = await Storage.readTrustchainOperation(fileName);
      createdDid.value = await file.readAsString();

    } on FfiException catch(e) {
      var err = FfiError.parseFfiError(e);
      print("${err.varient.code}: ${err.info}");
      switch (err.varient) {
        case FfiError.failedToDeserialise:
          createInputError.value = "Invalid JSON: ${err.info}";
          break;
        default:
          createInputError.value = "Unexpected Error: ${err.info}";
      }
    } catch (e) {
      rethrow;  // rethrow the error if it originates from dart rather than the ffi
    }
    
  }

  void doAttest() async {
    attestInputError.value = null;
    try {
      await api.attest(did: attestDidInputCtrl.text,
                controlledDid: attestControlledDidInputCtrl.text,
                verbose: true);
    } on FfiException catch(e) {
      var err = FfiError.parseFfiError(e);
      print("${err.varient.code}: ${err.info}");
      switch (err.varient) {
        case FfiError.failedToAttestdDID:
          attestInputError.value = "Attestation Failed: ${err.info}";
          break;
        default:
          attestInputError.value = "Unexpected Error: ${err.info}";
      }
    } catch (e) {
      rethrow;  // rethrow the error if it originates from dart rather than the ffi
    }
  }

  void doVerify() async {
    verifyInputError.value = null;
    // api.verify(did: verifyDIDInputCtrl.text).then((val) => {
    //   setState(() {
    //     print(val);
    //     Map<String, dynamic> map = jsonDecode(val);
    //     verifiedChainMap = map.cast<String, List<Map<String, dynamic>>>();
    //   })
    // });
    try {
      verifiedChain.value = await api.verify(did: verifyDIDInputCtrl.text);
    } on FfiException catch(e) {
      var err = FfiError.parseFfiError(e);
      print("${err.varient.code}: ${err.info}");
      switch (err.varient) {
        case FfiError.failedToVerifyDID:
          verifyInputError.value = "Verification Error: ${err.info}";
          break;
        default:
          resolveInputError.value = "Unexpected Error: ${err.info}";
      }
    } catch (e) {
      rethrow;  // rethrow the error if it originates from dart rather than the ffi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50,left: 50,right: 50),
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 50),
        itemCount: 4,
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 30,),
        itemBuilder: (BuildContext context, int index) {
          return [
          // RESOLVE____________________________________________________________
          Card(
            shape: RoundedRectangleBorder(borderRadius: UiKit.constraints.buttonRadius),
            color: UiKit.palette.navBarBackground,
            shadowColor: UiKit.palette.shadow,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Resolve a DID",style: UiKit.text.textTheme.labelLarge),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ValueListenableBuilder(
                      valueListenable: resolveInputError,
                      builder: (context,resolveErr, widget) {
                        return TextField(
                          style: UiKit.text.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText: 'Enter a DID',
                            hintStyle: UiKit.text.textTheme.bodyMedium,
                            focusColor: UiKit.palette.textFieldBorder,
                            errorText: resolveErr ?? resolveErr,
                          ),
                          controller: resolveInputCtrl,
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 200,
                    child: BaseButton.primary(onPressed: doResolve, child: Text("Resolve"))),
                  if (resolvedDid != null)...[
                    SizedBox(height: 20,),
                    DIDDocumentWidget(
                      model: DIDDocumentWidgetModel.fromDIDModel(
                        DIDModel.fromMap(
                          jsonDecode(resolvedDid!)
                    )))
                  ]
                ],
              ),
            )
          ),
          // CREATE____________________________________________________________
          Card(
            shape: RoundedRectangleBorder(borderRadius: UiKit.constraints.buttonRadius),
            color: UiKit.palette.navBarBackground,
            shadowColor: UiKit.palette.shadow,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Create a DID",style: UiKit.text.textTheme.labelLarge),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ValueListenableBuilder(
                      valueListenable: createInputError,
                      builder: (context, createErr, widget) {
                        return TextField(
                          style: UiKit.text.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText: 'Optionally enter doc-state',
                            hintStyle: UiKit.text.textTheme.bodyMedium,
                            focusColor: UiKit.palette.textFieldBorder,
                            errorText: createErr ?? createErr,
                          ),
                          controller: createInputCtrl,
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 200,
                    child: BaseButton.primary(onPressed: doCreate, child: Text("Create"))),
                  ValueListenableBuilder(
                    valueListenable: createdDid,
                    builder: (context, value, widget) {
                      if (value != null) {
                        return Column(
                          children: [
                            SizedBox(height: 20,),
                            ExpandableText(
                                value,
                                expandText: 'show',
                                collapseText: '\n\n hide',
                                maxLines: 1,
                                linkColor: Colors.blue,
                            ),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }
                  ),
                ],
              ),
            )
          ),
          // ATTEST____________________________________________________________
          Card(
            shape: RoundedRectangleBorder(borderRadius: UiKit.constraints.buttonRadius),
            color: UiKit.palette.navBarBackground,
            shadowColor: UiKit.palette.shadow,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Attest to a DID",style: UiKit.text.textTheme.labelLarge),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      style: UiKit.text.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter a DID',
                        hintStyle: UiKit.text.textTheme.bodyMedium,
                        focusColor: UiKit.palette.textFieldBorder,
                  
                      ),
                      controller: attestDidInputCtrl,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ValueListenableBuilder(
                      valueListenable: attestInputError,
                      builder: (context, attestErr, widget) {
                        return TextField(
                          style: UiKit.text.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Enter a Controlled DID',
                            hintStyle: UiKit.text.textTheme.bodyMedium,
                            focusColor: UiKit.palette.textFieldBorder,
                            errorText: attestErr ?? attestErr,
                          ),
                          controller: attestControlledDidInputCtrl,
                        );
                      }
                    )
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 200,
                    child: BaseButton.primary(onPressed: doAttest, child: Text("Attest"))),
                  // if (createdDid.isNotEmpty)...[
                  //   SizedBox(height: 20,),
                  //   DIDDocumentWidget(model: DIDDocumentWidgetModel(createdDid,"TODO"))
                  // ]
                ],
              ),
            )
          ),
          // VERIFY____________________________________________________________
          Card(
            shape: RoundedRectangleBorder(borderRadius: UiKit.constraints.buttonRadius),
            color: UiKit.palette.navBarBackground,
            shadowColor: UiKit.palette.shadow,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Verify a DID",style: UiKit.text.textTheme.labelLarge),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ValueListenableBuilder(
                      valueListenable: verifyInputError,
                      builder: (context, verifyErr, widget) {
                        return TextField(
                          style: UiKit.text.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Enter a DID',
                            hintStyle: UiKit.text.textTheme.bodyMedium,
                            focusColor: UiKit.palette.textFieldBorder,
                            errorText: verifyErr ?? verifyErr,
                          ),
                          controller: verifyDIDInputCtrl,
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 200,
                    child: BaseButton.primary(onPressed: doVerify, child: Text("Verify"))),
                  ValueListenableBuilder(
                    valueListenable: verifiedChain,
                    builder: (context, value, widget) {
                      if (value != null) {
                        return Column(
                          children: [
                            SizedBox(height: 20,),
                            ExpandableText(
                                value,
                                expandText: 'show',
                                collapseText: '\n\n hide',
                                maxLines: 1,
                                linkColor: Colors.blue,
                                expanded: true
                            ),
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }
                  ),
                ],
              ),
            )
          ),
        ][index];
        },
      ),
    );
  }
}

class DIDPage extends StatefulWidget {
  @override
  State<DIDPage> createState() => _DIDPageState();
}
