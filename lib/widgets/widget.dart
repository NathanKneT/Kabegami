import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:wallpaper_newapp/model/wallpaper_model.dart';
import 'package:wallpaper_newapp/views/image_view.dart';

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
            FocusedMenuItem(title: Text("Download"), onPressed:(){},trailingIcon: Icon(Icons.download),backgroundColor: Theme.of(context).indicatorColor, ),
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
