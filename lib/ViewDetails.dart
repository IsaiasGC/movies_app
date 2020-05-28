import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget{
  Map<String, dynamic> movie;
  ViewDetails(this.movie);
  @override
  State<StatefulWidget> createState() => ViewDetailsForm(movie);

}
class ViewDetailsForm extends State<ViewDetails>{
  Map<String, dynamic> movie;
  ViewDetailsForm(this.movie);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         title: Text(movie['title']),
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
                child: Image.network("https://image.tmdb.org/t/p/w500"+movie['backdrop_path'],),

              ),
              Container(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  movie['overview'],
                  textAlign: TextAlign.justify,
                ),

              ),
              Container(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "Fecha de estreno "+
                      movie['release_date'],
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