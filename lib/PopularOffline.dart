import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movies_app/Movie.dart';
import 'package:movies_app/ViewDetails.dart';
import 'package:movies_app/DBProvider.dart';


class PopularOffline extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PopularOfflineForm();
}

class PopularOfflineForm extends State<PopularOffline>{
  var isLoading=false;
  List<Movie> movies;

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: DBProvider.db.getAllPopular(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        movies=snapshot.data;
        log("PopularOffline: ${snapshot.hasData}");
        return !snapshot.hasData ? Center(child: CircularProgressIndicator(),)
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
                                padding: EdgeInsets.symmetric(horizontal: 27.0),
                                // decoration: BoxDecoration(
                                //   border: Border( right: BorderSide(width: 1.0, color: Colors.black))
                                // ),
                                child: Icon(Icons.photo, size: 50.00, color: Theme.of(context).textTheme.bodyText1.color,),
                              ),
                              title: Text(
                                movies[index].title,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  //Icon(Icons.touch_app, color: Colors.yellowAccent),
                                  Text(movies[index].date, style: Theme.of(context).textTheme.bodyText2)
                                ],
                              ),
                              // trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0,),
                            ),
                          ),
                    ),
                    actions: <Widget>[
                      IconSlideAction(
                      foregroundColor: Colors.red,
                      caption: 'add to favorite',
                      color: Colors.grey[850],
                      icon: Icons.favorite,
                      onTap: () => {
                        // addFavorite(index, context)
                      },
                    ),
                    IconSlideAction(
                      foregroundColor: Color.fromARGB(255, 23, 162, 184),
                      caption: 'view detail',
                      color: Colors.grey[850],
                      icon: Icons.open_in_new,
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDetails(movies[index].toJson(), false),
                          ),
                        )
                      },
                    ),
                    ],
                  );
                },
              );
      }
    );
  }
}