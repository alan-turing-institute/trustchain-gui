import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_flutter/credible_imports/credible_shared_widget/base/button.dart';
import 'package:learn_flutter/credible_imports/trustchain_widgets/document.dart';
import 'package:learn_flutter/ffi.dart';
import 'package:learn_flutter/ui/ui.dart';
import 'package:learn_flutter/credible_imports/credible_shared_widget/tooltip_text.dart';

class _DIDPageState extends State<DIDPage> {
  final resolveInputCtrl = TextEditingController();
  final createInputCtrl = TextEditingController();
  final verifyDIDInputCtrl = TextEditingController();
  final verifyRTSInputCtrl = TextEditingController();

  var resolvedDid = '';
  var createdDid = '';
  var attestReturn = '';
  var verifiedChain = '';

  void doResolve() {
    api.resolve(did: resolveInputCtrl.text).then((value) => {
      setState(() {
        resolvedDid = value;
      })
    });
  }

  void doCreate() {
    var config = resolveInputCtrl.text;

    api.create(
      verbose: true,
      // docStateStr:
      // '''
      // {
      //   "services": [
      //     {
      //       "id": "12345",
      //       "r#type": "6789101112",
      //       "service_endpoint": "https://testendpointnameeasytospotlater.com"
      //     }
          
      //   ]
      // }
      // '''
    );
  }

  void doAttest() {
    api.attest().then((value) => {
      setState(() {
        attestReturn = value;
      })
    });
  }

  void doVerify() {
    api.didVerify(did: verifyDIDInputCtrl.text, rootTimestamp: int.parse(verifyRTSInputCtrl.text)).then((val) => {
      setState(() {
        verifiedChain = val;
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
                  if (resolvedDid.isNotEmpty)...[
                    SizedBox(height: 20,),
                    DIDDocumentWidget(model: DIDDocumentWidgetModel(resolvedDid,"TODO"))
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
                  if (createdDid.isNotEmpty)...[
                    SizedBox(height: 20,),
                    DIDDocumentWidget(model: DIDDocumentWidgetModel(createdDid,"TODO"))
                  ]
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
                        hintText: 'TODO...',
                        hintStyle: UiKit.text.textTheme.bodyMedium,
                        focusColor: UiKit.palette.textFieldBorder,
                  
                      ),
                      controller: createInputCtrl,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      style: UiKit.text.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter a root timestamp',
                        hintStyle: UiKit.text.textTheme.bodyMedium,
                        focusColor: UiKit.palette.textFieldBorder,
                  
                      ),
                      controller: verifyRTSInputCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 200,
                    child: BaseButton.primary(onPressed: doVerify, child: Text("Verify"))),
                  if (verifiedChain.isNotEmpty)...[
                    SizedBox(height: 20,),
                    DIDDocumentWidget(model: DIDDocumentWidgetModel(verifiedChain,"TODO"))
                  ]
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
