import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:like_button/like_button.dart';
import 'package:wallpaper_newapp/views/report.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;

  ImageView({@required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  static const double _appBarBottomBtnPosition = 24.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.transparent,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(bottom: 25),
                  title: buttonDownload(context),
                  background: Image.network(
                    widget.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
          ),
                SliverFixedExtentList(
                  itemExtent: 400.00, delegate: SliverChildListDelegate([
                detailsModal(context)
              ],),)
            ],
          ),
        ),
    );
  }

  Widget buttonDownload(context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _save();
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff1C1B1B).withOpacity(0.8),
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  padding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      border:
                      Border.all(color: Colors.white54, width: 1),
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(colors: [
                        Color(0x36FFFFFF),
                        Color(0x0EFFFFFF)
                      ])),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Set Wallpaper",
                        style: TextStyle(
                            fontSize: 16, color: Colors.white70),
                      ),
                      Text(
                        "image will be saved in gallery",
                        style: TextStyle(
                            fontSize: 10, color: Colors.white70),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

Widget _buildChip(String label) {
  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Color(0xff848989),
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: EdgeInsets.all(8.0),
  );
}

Widget detailsModal(context) {
  final int likeCount = 999;
  final GlobalKey<LikeButtonState> _globalKey = GlobalKey<LikeButtonState>();
  final double buttonSize = 40.0;
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                  Color(0x36FFFFFF),
              Color(0xE111111) ],),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.portrait,
                        size: buttonSize,),
                        Text("John DOE"),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.file_download,
                        size: buttonSize,),
                        Text("1452"),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.label,
                        size: buttonSize,),
                         Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: <Widget>[
                          _buildChip('Doge'),
                          _buildChip('To'),
                          _buildChip('The Moon'),
                        ],
                        ),]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.flag,
                        size: buttonSize,),
                        Text("Report"),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LikeButton(
                        size: buttonSize,
                        likeCount: likeCount,
                        key: _globalKey,
                        countBuilder: (int count, bool isLiked, String text) {
                          final ColorSwatch<int> color =
                              isLiked ? Colors.red : Colors.grey;
                          Widget result;
                          if (count == 0) {
                            result = Text(
                              'love',
                              style: TextStyle(color: color),
                            );
                          } else
                            result = Text(
                              count >= 1000
                                  ? (count / 1000.0).toStringAsFixed(1) + 'k'
                                  : text,
                              style: TextStyle(color: color),
                            );
                          return result;
                        },
                        likeCountAnimationType: likeCount < 1000
                            ? LikeCountAnimationType.part
                            : LikeCountAnimationType.none,
                        likeCountPadding: const EdgeInsets.only(left: 15.0),
                      ),
                    ]),
              ],
            ),
          ),
        );
}


  _save() async {
    if (Platform.isAndroid) {
      await _askPermission();
    }
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
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
}

class ReportTile extends StatelessWidget {
  final String title;

  ReportTile({@required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Report(
                  wallpaper: title.toLowerCase(),
                )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}