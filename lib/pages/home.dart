import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/did.dart';
import 'package:learn_flutter/pages/splash.dart';
import 'package:learn_flutter/pages/vc.dart';
import 'package:learn_flutter/pages/sandbox.dart';
import 'package:learn_flutter/ui/ui.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = SplashPage();
        break;
      case 1:
        page = DIDPage();
        break;
      case 2:
        page = VCPage();
        break;
      case 3:
        page = SandboxPage();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.perm_identity),
                      label: Text('DID Functionality'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.document_scanner_outlined),
                      label: Text('VC Functionality'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.build),
                      label: Text('Sandbox'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: UiKit.palette.shadow,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}