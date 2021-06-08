import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:like_button/like_button.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;

  ImageView({@required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _textMail = TextEditingController();
          final TextEditingController _textEditingController =
              TextEditingController();
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12,sigmaY: 12),
              child: AlertDialog(
                content: SizedBox(
                        width: 400.0,
                        height: 300.0,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor,
                                    borderRadius: BorderRadius.circular(32)),
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                child: Row(children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      controller: _textMail,
                                      validator: (value) {
                                        return value.isValidEmail()
                                            ? null
                                            : "Invalid Field";
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Mail",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ]),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor,
                                    borderRadius: BorderRadius.circular(32)),
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                height: 120.0,
                                child: Row(children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      controller: _textEditingController,
                                      validator: (value) {
                                        return value.isNotEmpty
                                            ? null
                                            : "Invalid Field";
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Message",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("I'm the artist"),
                                  Checkbox(
                                      value: isChecked,
                                      onChanged: (checked) {
                                        setState(() {
                                          isChecked = checked;
                                        });
                                      })
                                ],
                              )
                            ],
                          ))),
                      ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Send'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // Do something like updating SharedPreferences or User Settings etc.
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            bottom: PreferredSize(
              child: buttonDownload(context),
              preferredSize: Size(100, 10),
            ),
            pinned: false,
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: Stack(
              children: [
                Positioned(
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.imgUrl,
                      ),
                    ),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0),
                Positioned(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                  ),
                  bottom: -1,
                  left: 0,
                  right: 0,
                ),
              ],
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 400.0,
            delegate: SliverChildListDelegate(
              [detailsModal(context)],
            ),
          ),
        ],
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54, width: 1),
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: [Color(0x36FFFFFF), Color(0x0EFFFFFF)])),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Set Wallpaper",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      Text(
                        "image will be saved in gallery",
                        style: TextStyle(fontSize: 10, color: Colors.white70),
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

  Widget detailsModal(context) {
    final int likeCount = 999;
    final GlobalKey<LikeButtonState> _globalKey = GlobalKey<LikeButtonState>();
    final double buttonSize = 40.0;
    return Container(
      color: Theme.of(context).dividerColor,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(
                Icons.portrait,
                size: buttonSize,
              ),
              Text("John DOE"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(
                Icons.file_download,
                size: buttonSize,
              ),
              Text("1452"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(
                Icons.label,
                size: buttonSize,
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: <Widget>[
                  _buildChip('Doge'),
                  _buildChip('To'),
                  _buildChip('The Moon'),
                ],
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent)),
                onPressed: () async {
                  await showInformationDialog(context);
                },
                child: Icon(
                  Icons.flag,
                  size: buttonSize,
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
