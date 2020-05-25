import 'package:flutter/material.dart';
import 'package:movies_app/Splash.dart';

void main() => runApp(App());



class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      // routes: {
      //   '/' : (context)=>Splash(),
      //   '/dashboard' : (context)=>Dashboard(),
      //   '/popular' : (context)=>Popular(),
      //   '/search' : (context)=>Search(),
      //   '/favorite' : (context)=>Favorite(),
      // },
      // theme: ThemeData(
      //   primaryColor: Colors.black38,
        // primaryTextTheme: TextTheme(
        //   title: TextStyle(color: Colors.white),
        // ),
      //   accentColor: Colors.green,
      //   backgroundColor: Colors.black,
      //   bottomAppBarColor: Colors.black38,
      //   textTheme: TextTheme(
      //     body1: TextStyle(color: Colors.white),
      //     body2: TextStyle(color: Colors.white),
      //   ),
      // ),
      title: 'Movies App',
      home: Splash(),
    );
  }
}