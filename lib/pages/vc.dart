import 'package:flutter/material.dart';
import 'package:trustchain_gui/ui/ui.dart';
import 'package:trustchain_gui/credible_imports/credible_shared_widget/base/button.dart';
import 'package:trustchain_dart/trustchain_dart.dart';
import 'dart:io';
import 'package:trustchain_gui/ffi.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:expandable_text/expandable_text.dart';

class VCPage extends StatelessWidget {
  final signVCInputCtrl = TextEditingController();
  final signKeyDidInputCtrl = TextEditingController();
  final signedVC = ValueNotifier<String?>(null);
  final signInputError = ValueNotifier<String?>(null);

  void doSign() async {
    signInputError.value = null;
    // File file = await Storage.readTrustchainDidJWK(signKeyDidInputCtrl.text);
    // String jwk = await file.readAsString();
    // print(jwk);
    try {
      signedVC.value = await api.vcSign(serialCredential: signVCInputCtrl.text, did: signKeyDidInputCtrl.text);
    } on FfiException catch(e) {
      var err = FfiError.parseFfiError(e);
      print("${err.varient.code}: ${err.info}");
      switch (err.varient) {
        case FfiError.failedToDeserialise:
          signInputError.value = "Invalid JSON: ${err.info}";
          break;
        default:
          signInputError.value = "Unexpected Error: ${err.info}";
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
        itemCount: 1,
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 30,),
        itemBuilder: (BuildContext context, int index) {
          return [
          // SIGN____________________________________________________________
          Card(
            shape: RoundedRectangleBorder(borderRadius: UiKit.constraints.buttonRadius),
            color: UiKit.palette.navBarBackground,
            shadowColor: UiKit.palette.shadow,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Sign a Verfiable Credential",style: UiKit.text.textTheme.labelLarge),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      style: UiKit.text.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter a VC',
                        hintStyle: UiKit.text.textTheme.bodyMedium,
                        focusColor: UiKit.palette.textFieldBorder,
                  
                      ),
                      controller: signVCInputCtrl,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ValueListenableBuilder(
                      valueListenable: signInputError,
                      builder: (context,signErr, widget) {
                        return TextField(
                          style: UiKit.text.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText: 'Enter a DID',
                            hintStyle: UiKit.text.textTheme.bodyMedium,
                            focusColor: UiKit.palette.textFieldBorder,
                            errorText: signErr ?? signErr,
                          ),
                          controller: signKeyDidInputCtrl,
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 200,
                    child: BaseButton.primary(onPressed: doSign, child: Text("Sign"))),
                  ValueListenableBuilder(
                    valueListenable: signedVC,
                    builder: (context, value, widget) {
                      if (value != null) {
                        return Column(
                          children: [
                            SizedBox(height: 20,),
                            ExpandableText(
                                value,
                                expandText: 'show signed VC',
                                collapseText: '\n\n hide signed VC',
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

