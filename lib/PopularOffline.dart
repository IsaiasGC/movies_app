import 'dart:convert' as convert;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/ViewDetails.dart';
import 'package:path/path.dart';


class PopularOffline extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PopularOfflineForm();
}

class PopularOfflineForm extends State<PopularOffline>{
  var isLoading=false;
  List movies;
  
  Future<String> getPopulars() async{
    this.setState((){
      isLoading=true;
    });
    
    return "Accept";
  }

  @override
  void initState(){
    getPopulars();
  }
  
  @override
  Widget build(BuildContext context){
    return isLoading ? Center(child: CircularProgressIndicator(),)
            : ListView.builder(
              itemCount: movies==null ? 0 : movies.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Card(
                    elevation: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
                    child: Container(
                          // decoration: BoxDecoration(color: Color.fromRGBO(50, 180, 237, .8)),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.5),
                            leading: Container(
                              padding: EdgeInsets.only(right: 5.0),
                              // decoration: BoxDecoration(
                              //   border: Border( right: BorderSide(width: 1.0, color: Colors.black))
                              // ),
                              child: Image.network("https://image.tmdb.org/t/p/w500"+movies[index]['backdrop_path'],),
                            ),
                            title: Text(
                              movies[index]['title'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                //Icon(Icons.touch_app, color: Colors.yellowAccent),
                                Text(movies[index]['release_date'], style: Theme.of(context).textTheme.bodyText2)
                              ],
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0,),
                          ),
                        ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'add to favorite',
                      color: Color.fromARGB(255, 189, 100, 10),
                      icon: Icons.favorite,
                      onTap: () => {
                        // addFavorite(index, context)
                      },
                    ),
                    IconSlideAction(
                      caption: 'view detail',
                      color: Color.fromARGB(255, 23, 162, 184),
                      icon: Icons.open_in_new,
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDetails(movies[index]),
                          ),
                        )
                      },
                    ),
                  ],
                );
              },
        );
  }
}