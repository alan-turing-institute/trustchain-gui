import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var verifiedChainMap;

  void doResolve() {
    api.resolve(did: resolveInputCtrl.text).then((value) => {
      setState(() {
        resolvedDid = value;
      })
    });
  }

  void doCreate() {
    var docState = createInputCtrl.text;
    if (docState.isNotEmpty) {
      api.create(verbose: true, docState: docState);
    } else {
      api.create(verbose: true);
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

  void doAttest() {
    api.attest(did: attestDidInputCtrl.text,
                controlledDid: attestControlledDidInputCtrl.text,
                verbose: true);
  }

  void doVerify() {
    api.verify(did: verifyDIDInputCtrl.text).then((val) => {
      setState(() {
        print(val);
        Map<String, dynamic> map = jsonDecode(val);
        verifiedChainMap = map.cast<String, List<Map<String, dynamic>>>();
      })
    });
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
                    DIDDocumentWidget(model: DIDDocumentWidgetModel(resolvedDid!,"TODO!"))
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
