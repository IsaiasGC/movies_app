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
      title: 'Movies App',
      home: Splash(),
    );
  }
}