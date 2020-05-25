import 'package:flutter/material.dart';

class Favorite extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return FavoriteForm();
  }
}

class FavoriteForm extends State<Favorite>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Favorite'),),
      body: Center(child: Icon(Icons.network_check, size: 64.0, color: Colors.redAccent)),
    );
  }
}