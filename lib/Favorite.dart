import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:movies_app/FavoriteLine.dart';
import 'package:movies_app/FavoriteOffline.dart';


class Favorite extends StatelessWidget{
  var isLoading=false;
  List movies;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(title: Text('Favorite'),),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
         
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: 25.0,
                height: connected ? 0.0 : 25.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: Color(0xFFEE4400),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: connected ? <Widget>[] 
                      : <Widget>[
                          Text("OFFLINE ", style: TextStyle(color: Colors.white70),),
                        // CircularProgressIndicator()
                        ],
                      ),
                    ),
                  ),
                ),
                connected ? FavoriteLine() : FavoriteOffline()
            ]
          );
        },child: Text("data")
      ),
    );
  }
}