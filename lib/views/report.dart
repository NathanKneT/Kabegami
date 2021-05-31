import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_newapp/data/data.dart';
import 'package:wallpaper_newapp/model/wallpaper_model.dart';
import 'package:wallpaper_newapp/widgets/widget.dart';

class Report extends StatefulWidget {
  final String wallpaper;

  Report({this.wallpaper});

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
              labelText: 'Explain'
          ),
        ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
  }





