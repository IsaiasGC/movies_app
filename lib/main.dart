import 'package:flutter/material.dart';
import 'package:movies_app/Splash.dart';

void main() => runApp(App());



class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
        accentColor: Colors.grey,
        cardColor: Colors.black87,
        secondaryHeaderColor: Colors.blueGrey[700],
        colorScheme: ColorScheme.dark(
          secondary: Colors.green,
        ),
        
        // Define the default font family.
        fontFamily: 'Roboto',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 25.0, color: Colors.white),
          headline6: TextStyle(fontSize: 20.0, color: Colors.white),
          bodyText2: TextStyle(fontFamily: 'Hind', color: Colors.white70),
          bodyText1: TextStyle(fontFamily: 'Hind', fontWeight: FontWeight.bold, color: Colors.white70),
        ),
      ),
      title: 'Movies App',
      home: Splash(),
    );
  }
}