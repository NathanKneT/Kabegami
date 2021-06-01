import 'package:flutter/material.dart';
import 'package:wallpaper_newapp/widgets/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kabegami',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        canvasColor: Colors.transparent
      ),
      home: Nav(),
    );
  }
}
