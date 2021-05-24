import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_newapp/views/home.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<DisplayMode> modes = <DisplayMode>[];
  DisplayMode? active;
  DisplayMode? preferred;

  final ValueNotifier<int> page = ValueNotifier<int>(0);
  late final PageController controller = PageController()
    ..addListener(() {
      page.value = controller.page!.round();
    });

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      fetchAll();
    });
  }

  Future<void> fetchAll() async {
    try {
      modes = await FlutterDisplayMode.supported;
      modes.forEach(print);

      /// On OnePlus 7 Pro:
      /// #1 1080x2340 @ 60Hz
      /// #2 1080x2340 @ 90Hz
      /// #3 1440x3120 @ 90Hz
      /// #4 1440x3120 @ 60Hz
      /// On OnePlus 8 Pro:
      /// #1 1080x2376 @ 60Hz
      /// #2 1440x3168 @ 120Hz
      /// #3 1440x3168 @ 60Hz
      /// #4 1080x2376 @ 120Hz
    } on PlatformException catch (e) {
      print(e);

      /// e.code =>
      /// noAPI - No API support. Only Marshmallow and above.
      /// noActivity - Activity is not available. Probably app is in background
    }

    preferred = await FlutterDisplayMode.preferred;

    active = await FlutterDisplayMode.active;

    setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kabegami',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Home(),
    );
  }
}
