import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_newapp/widgets/widget.dart';
import 'package:wallpaper_newapp/data/data.dart';
import 'package:wallpaper_newapp/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class New extends StatefulWidget {
  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getNewWallpapers() async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=15&page=3"),
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getNewWallpapers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('New'),
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                wallpapersList(wallpapers: wallpapers, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
