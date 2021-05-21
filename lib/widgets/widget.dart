import 'package:flutter/material.dart';
import 'package:wallpaper_newapp/model/wallpaper_model.dart';
import 'package:wallpaper_newapp/views/image_view.dart';

Widget brandNameSearch() {
  return RichText(
    text : TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    children: <TextSpan>[
      TextSpan(text: "Kabe",  style: TextStyle(color: Colors.black87)),
      TextSpan(text: "Gami",  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
    ],
  ),
  );
}

Widget brandName() {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        children: const <TextSpan>[
          TextSpan(text: 'Kabe', style: TextStyle(color: Colors.black87)),
          TextSpan(
              text: 'gami',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
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
        return GridTile(
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
        );
      }).toList(),
    ),
  );
}
