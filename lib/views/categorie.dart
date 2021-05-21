import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_newapp/data/data.dart';
import 'package:wallpaper_newapp/model/wallpaper_model.dart';
import 'package:wallpaper_newapp/widgets/widget.dart';
import "package:wallpaper_newapp/widgets/string_extension.dart";


class Categorie extends StatefulWidget {
  final String categorieName;

  Categorie({this.categorieName});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers(String query) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=15&page=1"),
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
    getSearchWallpapers(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.categorieName.capitalize();
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                wallpapersList(wallpapers: wallpapers, context: context)
              ],
            ),
          ),
        ));
  }
}
