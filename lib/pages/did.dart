import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:trustchain_gui/credible_imports/credible_shared_widget/base/button.dart';
import 'package:trustchain_dart/trustchain_dart.dart';
import 'package:trustchain_gui/credible_imports/trustchain_widgets/document.dart';

import 'package:trustchain_gui/credible_imports/trustchain_widgets/chain.dart';
import 'package:trustchain_gui/ffi.dart';
import 'package:trustchain_gui/ui/ui.dart';
import 'package:trustchain_gui/credible_imports/credible_shared_widget/tooltip_text.dart';

class _DIDPageState extends State<DIDPage> {
  final resolveInputCtrl = TextEditingController();
  final createInputCtrl = TextEditingController();
  final attestDidInputCtrl = TextEditingController();
  final attestControlledDidInputCtrl = TextEditingController();
  final verifyDIDInputCtrl = TextEditingController();

  String? resolvedDid;
  final createdDid = ValueNotifier<String?>(null);
  var verifiedChainMap;

  void doResolve() async {
    try {
      var did = await api.resolve(did: resolveInputCtrl.text);
      setState(() {
        resolvedDid = did;
      });
    } on FfiException catch(err) {
      print(err);
    } catch (err) {
      rethrow;  // rethrow the error if it originates from dart rather than the ffi
    }
  }

  void doCreate() async {
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
      // print(e.message);

      var err = FfiError.parseFfiError(e);
      switch (err.varient) {
        case FfiError.failedToDeserialise:
          print("You input invalid json: ${err.info}");
          break;
        case FfiError.failedToCreateDID:
          print("unexpected error creating DID: ${err.info}");
          break;
        default:
          print("Unhandled Error!");
      }
    } catch (e) {
      rethrow;  // rethrow the error if it originates from dart rather than the ffi
    }
    
  }
  // docStateStr:
  // '''
  // {
  //   "services": [
  //     {
  //       "id": "12345",
  //       "type": "6789101112",
  //       "serviceEndpoint": "https://testendpointnameeasytospotlater.com"
  //     }
      
  //   ]
  // }
  // '''

  void doAttest() async {
    try {
      await api.attest(did: attestDidInputCtrl.text,
                controlledDid: attestControlledDidInputCtrl.text,
                verbose: true);
    } on FfiException catch(e) {
      var err = FfiError.parseFfiError(e);
      switch (err.varient) {
        case FfiError.failedToAttestdDID:
          print("unexpected error attesting: ${err.info}");
          break;
        default:
          print("Unhandled Error!");
          print(e.message);
      }
    } catch (e) {
      rethrow;  // rethrow the error if it originates from dart rather than the ffi
    }
  }

  void doVerify() async {
    // api.verify(did: verifyDIDInputCtrl.text).then((val) => {
    //   setState(() {
    //     print(val);
    //     Map<String, dynamic> map = jsonDecode(val);
    //     verifiedChainMap = map.cast<String, List<Map<String, dynamic>>>();
    //   })
    // });
    try {
      final chain = await api.verify(did: verifyDIDInputCtrl.text);
      print(chain);
    } on FfiException catch(e) {
      // print(e.message);
      var err = FfiError.parseFfiError(e);
      switch (err.varient) {
        case FfiError.failedToVerifyDID:
          print("unexpected error verifying did: ${err.info}");
          break;
        default:
          print("Unhandled Error!");
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
                    child: TextField(
                      style: UiKit.text.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter a DID',
                        hintStyle: UiKit.text.textTheme.bodyMedium,
                        focusColor: UiKit.palette.textFieldBorder,
                  
                      ),
                      controller: resolveInputCtrl,
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
                    child: TextField(
                      style: UiKit.text.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Optionally enter doc-state',
                        hintStyle: UiKit.text.textTheme.bodyMedium,
                        focusColor: UiKit.palette.textFieldBorder,
                  
                      ),
                      controller: createInputCtrl,
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
                          Text(value)
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
                    child: TextField(
                      style: UiKit.text.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter a Controlled DID',
                        hintStyle: UiKit.text.textTheme.bodyMedium,
                        focusColor: UiKit.palette.textFieldBorder,
                  
                      ),
                      controller: attestControlledDidInputCtrl,
                    ),
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
                    child: TextField(
                      style: UiKit.text.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter a DID',
                        hintStyle: UiKit.text.textTheme.bodyMedium,
                        focusColor: UiKit.palette.textFieldBorder,
                  
                      ),
                      controller: verifyDIDInputCtrl,
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 200,
                    child: BaseButton.primary(onPressed: doVerify, child: Text("Verify"))),
                  // if (verifiedChainMap != null)...[
                  //   SizedBox(height: 20,),
                  //   ListView(
                  //   children: DIDChainWidgetModel.fromDIDChainModel(DIDChainModel.fromMap(verifiedChainMap)).data
                  //       .map((w) => Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Row(
                  //               children: [
                  //                 Expanded(
                  //                     flex: 20,
                  //                     child: DIDDocumentWidget(model: w)),
                  //                 Expanded(
                  //                     flex: 2,
                  //                     child: Icon(Icons.check_circle_rounded,
                  //                         size: 40,
                  //                         color:
                  //                             Color.fromARGB(255, 7, 111, 10)))
                  //               ],
                  //             ),
                  //           ))
                  //       .toList(),
                  //     )
                  //   ]
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
