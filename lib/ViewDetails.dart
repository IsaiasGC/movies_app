import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget{
  List movies;
  int index;
  ViewDetails(this.movies);
  @override
  State<StatefulWidget> createState() => ViewDetailsForm(movies);

}
class ViewDetailsForm extends State<ViewDetails>{
  List movies;
  int index;
  ViewDetailsForm(this.movies);
  List casting;
  String parsedCastign = "";
  var isLoading=false;

  Future<String> getCast() async{
    int id = this.movies[this.index]['id'];
    String urlCredits = "https://api.themoviedb.org/3/movie/$id/credits?api_key=323f74918f363cfd35a67d3ea4a5316d";
    log(urlCredits);
    this.setState((){
      isLoading=true;
    });
    var response=await http.get(urlCredits,
        headers: {
          "Accept": "application/json",
        }
    );
    print('Status codeeee: ${response.statusCode}');
    if(response.statusCode==200){
      this.setState((){
        isLoading=false;
        casting = convert.jsonDecode(response.body)['cast'];
      });
    }else{
      casting = new List();
      this.setState((){
        isLoading=false;
      });
    }
    return "Accept";
  }

  String getParsedListCasting(){
    String parsedCasting = "No casting";
//    if (casting != null)
    for(var i=0; i<1; i++){
      log("$casting['cast_id']");
    }
//    else log(parsedCasting);
    return 'nil';
  }
  @override
  void initState(){
    getCast();
    getParsedListCasting();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text(movies[index]['title']),
       ),
        body: Container(
          height: MediaQuery.of(context).size.height-250,
          width: 400.0,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.center,
//                decoration: (color: Colors.grey[300]),
                child: Text(
                  "Sipnosis y trailer",
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),

              Container(
                padding: EdgeInsets.all(6.0),
                child: Image.network("https://image.tmdb.org/t/p/w500"+movies[index]['backdrop_path'],),

              ),
              Container(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  movies[index]['overview'],
                  textAlign: TextAlign.justify,
                ),

              ),
              Container(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "Fecha de estreno "+
                      movies[index]['release_date'],
                  textAlign: TextAlign.justify,
                ),

              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Agregar a Favoritos',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel!',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
    );

  }

}