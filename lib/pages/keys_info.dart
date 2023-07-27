import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class KeysInfoPage extends StatelessWidget {

  Future<String> getKeysFromPath(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final root = directory.path;
    // const root = '~';
    final file = File('$root/$path');
    return await file.readAsString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: Column(
        children: [
          FutureBuilder<String>(
            future: getKeysFromPath('.trustchain/key_list.txt'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              } else {
                return Center(
                    child: Column(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ));
              }
            })
        ],
      ),
    );
  }
}
