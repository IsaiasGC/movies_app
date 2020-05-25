import 'package:flutter/material.dart';

class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SearchForm();
}

class SearchForm extends State<Search>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Search'),),
      body: Center(child: Icon(Icons.network_check, size: 64.0, color: Colors.redAccent)),
    );
  }
}