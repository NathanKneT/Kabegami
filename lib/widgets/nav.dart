import 'package:flutter/material.dart';
import 'package:wallpaper_newapp/views/home.dart';
import 'package:wallpaper_newapp/views/new.dart';
import 'package:wallpaper_newapp/views/top.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[Home(), Top(), New()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.white,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'Top',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: 'New',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
