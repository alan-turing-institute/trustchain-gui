import 'package:flutter/material.dart';
import 'package:trustchain_gui/pages/home.dart';
import 'package:trustchain_gui/ui/ui.dart';


void main() {
  runApp(AppWidget());
}

class AppWidget extends StatefulWidget {
  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  ThemeData get _themeData {
    final themeData = ThemeData(
      brightness: Brightness.light,
      backgroundColor: UiKit.palette.background,
      primaryColor: UiKit.palette.primary,
      // ignore: deprecated_member_use
      accentColor: UiKit.palette.accent,
      textTheme: UiKit.text.textTheme,
    );

    return themeData;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Trustchain GUI',
        theme: _themeData,
        home: HomePage(),
      );
  }
}
