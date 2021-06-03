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
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primaryColorBrightness: Brightness.light,
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          accentColor: Colors.blue,
          dividerColor: Color(0xfff5f8fd),
          primaryColorDark: Colors.black87,
          canvasColor: Colors.transparent,
          appBarTheme: AppBarTheme(brightness: Brightness.light)),
      darkTheme: ThemeData(
          primaryColor: Colors.black,
          primaryColorBrightness: Brightness.dark,
          primaryColorLight: Colors.black,
          primarySwatch: Colors.orange,
          accentColor: Colors.orange,
          dividerColor: Color(0xff464646),
          brightness: Brightness.dark,
          primaryColorDark: Colors.white,
          indicatorColor: Colors.grey,
          canvasColor: Colors.black,
          appBarTheme: AppBarTheme(brightness: Brightness.dark) ),
      home: Nav(),
    );
  }
}


/*theme: ThemeData(
         primarySwatch: Colors.grey,
         primaryColor: Colors.white,
         brightness: Brightness.light,
         backgroundColor: const Color(0xFFE5E5E5),
         accentColor: Colors.black,
         accentIconTheme: IconThemeData(color: Colors.white),
         dividerColor: Colors.white54,
         canvasColor: Colors.transparent
      ),*/
/*theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF212121),
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
      ),*/