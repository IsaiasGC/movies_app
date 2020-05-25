import 'package:flutter/material.dart';
import 'package:movies_app/Dasboard.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SplashForm();
}

class SplashForm extends State<Splash>{
  // bool loged=false;
  // Future isLoged() async{
  //   SharedPreferences pref=await SharedPreferences.getInstance();
  //   loged=(pref.getBool('loged')??false);
  // }

  @override
  Widget build(BuildContext context){
    setState(() {
      // isLoged();
    });
    
    return SplashScreen(
      seconds: 4,
      image: Image.network("https://icons-for-free.com/iconfiles/png/512/clapper+cut+director+making+movie+take+icon-1320195777589696004.png"),
      navigateAfterSeconds: Dashboard(),
      title: Text("Movies App", 
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      gradientBackground: new LinearGradient(
        colors: [Colors.redAccent, Colors.black54], 
        begin: Alignment.center, 
        end: Alignment.bottomCenter
      ),
    );
  }
}