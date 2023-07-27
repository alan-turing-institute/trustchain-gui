// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
// import 'package:learn_flutter/credible_imports/credible_shared_widget/base/button.dart';
// import 'package:learn_flutter/credible_imports/trustchain_widgets/document.dart';
// import 'package:learn_flutter/ffi.dart';
// import 'package:learn_flutter/ui/ui.dart';
// import 'package:learn_flutter/credible_imports/credible_shared_widget/tooltip_text.dart';

// // class MyStruct {
// //     String a;
// //     int b;
// //     MySubStruct subStruct;
// //   }

// //   class MySubStruct {
// //     c: String
// //   }

// class _SandboxPageState extends State<SandboxPage> {
//   final resolveInputCtrl = TextEditingController();
//   final createInputCtrl = TextEditingController();
//   final verifyDIDInputCtrl = TextEditingController();
//   final verifyRTSInputCtrl = TextEditingController();

//   var doErrReturn = '';
//   var doCustomStructReturn = '';
//   var attestReturn = '';
//   var verifiedChain = '';

//   void doErr() async {
//     // dart-way of handling Futues
//     try {
//       await api.returnResult(erroring:true);

//     } on FfiException catch (err) { // type comes from flutter_rust_bridge package
//       if (err.code == 'RESULT_ERROR') {
//         var errCode = err.message.characters.getRange(0,5).toString();
//         switch (errCode) {
//           case '[001]':
//             print(err.message);
//             setState(() {
//               doErrReturn = err.toString();
//             });
//             break;
//           case '[002]':
//             // do something else
//             break;
//           default:
//             // throw custom error eg. UnhandledFfiResultType
//         }
//       } else {
//         // throw custom error eg. UnhandledFfiException
//       }
        
//     } catch (err) {
//       rethrow;  // rethrow the error if it originates from dart rather than the ffi
//     }
//   }

//   void doOk() {
//     // leaving the 'uncompleted' branch of the Future unhandled (because we know it will complete)
//     api.returnResult(erroring:false).then((value) => {
//       // handle unwrapped result
//       setState(() {
//         doErrReturn = value;
//       })
//     });
//   }

  

//   void doCustomStruct() {
//     api.returnCustomStruct().then((value) => {
//       setState(() {
//         doCustomStructReturn = '''
//           {
//             a: ${value.a},
//             b: ${value.b.toString()},
//             subStruct: {
//               c: ${value.subStruct.c}
//             }
//           }
//         ''';
//       })
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 50,left: 50,right: 50),
//       child: ListView.separated(
//         padding: EdgeInsets.only(bottom: 50),
//         itemCount: 2,
//         separatorBuilder: (BuildContext context, int index) => SizedBox(height: 30,),
//         itemBuilder: (BuildContext context, int index) {
//           return [
//           // RESOLVE____________________________________________________________
//           Card(
//             shape: RoundedRectangleBorder(borderRadius: UiKit.constraints.buttonRadius),
//             color: UiKit.palette.navBarBackground,
//             shadowColor: UiKit.palette.shadow,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Text("Handle a result",style: UiKit.text.textTheme.labelLarge),
//                   SizedBox(height: 20,),
//                   SizedBox(
//                     width: 200,
//                     child: BaseButton.primary(onPressed: doOk, child: Text("Ok"))),
//                   SizedBox(height: 20,),
//                   SizedBox(
//                     width: 200,
//                     child: BaseButton.primary(onPressed: doErr, child: Text("Err"))),
//                   if (doErrReturn.isNotEmpty)...[
//                     SizedBox(height: 20,),
//                     Text(doErrReturn)
//                   ]
//                 ],
//               ),
//             )
//           ),
//           // CREATE____________________________________________________________
//           Card(
//             shape: RoundedRectangleBorder(borderRadius: UiKit.constraints.buttonRadius),
//             color: UiKit.palette.navBarBackground,
//             shadowColor: UiKit.palette.shadow,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Text("Return a custom struct",style: UiKit.text.textTheme.labelLarge),
//                   SizedBox(height: 20,),
//                   SizedBox(
//                     width: 200,
//                     child: BaseButton.primary(onPressed: doCustomStruct, child: Text("Create"))),
//                   if (doCustomStructReturn.isNotEmpty)...[
//                     SizedBox(height: 20,),
//                     Text(doCustomStructReturn)
//                   ]
//                 ],
//               ),
//             )
//           ),
//         ][index];
//         },
//       ),
//     );
//   }
// }

// class SandboxPage extends StatefulWidget {
//   @override
//   State<SandboxPage> createState() => _SandboxPageState();
// }
