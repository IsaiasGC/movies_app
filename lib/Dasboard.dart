import 'package:flutter/material.dart';
import 'package:movies_app/Favorite.dart';
import 'package:movies_app/Popular.dart';
import 'package:movies_app/Search.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => DashboardForm();
}

class DashboardForm extends State<Dashboard>{
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Popular(),
      Search(),
      Favorite(),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.movie), title: Text('popular')),
      BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('search')),
      BottomNavigationBarItem(icon: Icon(Icons.star), title: Text('favorite')),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottmonNavBarItems,
      currentIndex: _currentTabIndex,
      fixedColor: Colors.black26,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
        // Navigator.pushReplacementNamed(context, '/route');
      },
    );
    return Scaffold(
      body: Center(
        child: _kTabPages[_currentTabIndex]
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}