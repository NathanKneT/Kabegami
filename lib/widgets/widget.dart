import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_newapp/model/wallpaper_model.dart';
import 'package:wallpaper_newapp/views/image_view.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Widget brandNameSearch(BuildContext context) {
  return RichText(
    text : TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    children: <TextSpan>[
      TextSpan(text: "Kabe",  style: TextStyle(color: Theme.of(context).primaryColorDark)),
      TextSpan(text: "Gami",  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
    ],
  ),
  );
}

Widget brandName(BuildContext context) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        children: <TextSpan>[
          TextSpan(text: "Kabe",  style: TextStyle(color: Theme.of(context).primaryColorDark)),
          TextSpan(text: "Gami",  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),// Constante problème
        ],
      ),
    ),
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return FocusedMenuHolder(
          menuWidth: MediaQuery.of(context).size.width*0.5,
          onPressed: (){},
          menuItems:<FocusedMenuItem>[
            FocusedMenuItem(title: Text("Download"), onPressed:() {
             // _save();
            },trailingIcon: Icon(Icons.download),backgroundColor: Theme.of(context).indicatorColor, ),
            FocusedMenuItem(title: Text("Like"), onPressed:(){},trailingIcon: Icon(Icons.favorite),backgroundColor: Theme.of(context).indicatorColor, ),
            FocusedMenuItem(title: Text("Share"), onPressed:(){},trailingIcon: Icon(Icons.share),backgroundColor:Theme.of(context).indicatorColor, ),
          ],
          child: GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageView(
                              imgUrl: wallpaper.src.portrait,
                            )));
              },
              child: Hero(
                tag: wallpaper.src.portrait,
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        wallpaper.src.portrait,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
/*
_save() async {
  if (Platform.isAndroid) {
    await _askPermission();
  }
  var response = await Dio()
      .get(wallpapersList.imgUrl, options: Options(responseType: ResponseType.bytes)); //En gros là faut que je link l'url de l'image
  final result =
  await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  print(result);
  Navigator.pop(context);
}

_askPermission() async {
  if (Platform.isIOS) {
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler()
        .requestPermissions([PermissionGroup.photos]);
  } else {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
  }
}
*/