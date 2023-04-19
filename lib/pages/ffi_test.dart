// import 'package:flutter/material.dart';
// import 'package:learn_flutter/ffi.dart';

// class _FfiPageState extends State<FfiPage> {
//   var did = '';

//   void doResolve() {
//     api.resolve(did: "did:ion:test:EiAtHHKFJWAk5AsM3tgCut3OiBY4ekHTf66AAjoysXL65Q").then((value) => {
//       setState(() {
//         did = value;
//       })
//     });
//   }
//   void doCreate() {
//     api.create(
//       verbose: true,
//       // docStateStr:
//       // '''
//       // {
//       //   "services": [
//       //     {
//       //       "id": "12345",
//       //       "r#type": "6789101112",
//       //       "service_endpoint": "https://testendpointnameeasytospotlater.com"
//       //     }
          
//       //   ]
//       // }
//       // '''
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(100.0),
//       child: Column(
//         children: [
//           FutureBuilder<String>(
//             future: api.greet(),
//             builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!);
//               } else {
//                 return Center(
//                     child: Column(
//                   children: [
//                     SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: CircularProgressIndicator(),
//                     ),
//                   ],
//                 ));
//               }
//             }),
//           ElevatedButton(
//             onPressed: doResolve,
//             child: Text('Resolve')),
//           Text(did),
//           ElevatedButton(
//             onPressed: doCreate,
//             child: Text('Create')),
//         ],
//       ),
//     );
//   }
// }

// class FfiPage extends StatefulWidget {
//   @override
//   State<FfiPage> createState() => _FfiPageState();
// }

  
