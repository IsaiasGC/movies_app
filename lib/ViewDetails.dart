import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewDetails extends StatefulWidget{
  Map<String,dynamic> movie;
  ViewDetails(this.movie);
  @override
  State<StatefulWidget> createState() => ViewDetailsForm(movie);

}
class ViewDetailsForm extends State<ViewDetails>{
  final String urlAddFavorite="https://api.themoviedb.org/3/list/143905/add_item?api_key=323f74918f363cfd35a67d3ea4a5316d&session_id=0d0f33396cc0edd0999380e7ea3df066a039866a";
  Map<String,dynamic> movie;
  ViewDetailsForm(this.movie);
  List casting;
  var isLoading=false;

  Future<String> getCast() async{
    int id = this.movie['id'];
    String urlCredits = "https://api.themoviedb.org/3/movie/$id/credits?api_key=323f74918f363cfd35a67d3ea4a5316d";
    // log(urlCredits);
    this.setState((){
      isLoading=true;
    });
    var response=await http.get(urlCredits,
        headers: {
          "Accept": "application/json",
        }
    );
    print('Status code: ${response.statusCode}');
    if(response.statusCode==200){
      this.setState((){
        casting = convert.jsonDecode(response.body)['cast'];
        isLoading=false;
      });
    }else{
      casting = new List();
      this.setState((){
        isLoading=false;
      });
    }
    return "Accept";
  }
  Future<String> addFavorite(BuildContext context) async{
    String bodyJSON='{ "media_id" : ${movie['id']} }';
    var response=await http.post(urlAddFavorite,
      headers: {
        "Content-Type": "application/json;charset=utf-8",
      },
      body: bodyJSON
    );
    print('Status code: ${response.statusCode}');
    if(response.statusCode==201){
      // print('Se agrego exitosamente a Favortie');
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('${movie['title']} Se añadio a Favortie'),
      //   ),
      // );
      Fluttertoast.showToast(
        msg: "${movie['title']} Se añadio a Favortie",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white70,
        fontSize: 16.0
      );
    }else{
      // print('No se pudo Agregar a Favorite');
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('No se pudo Agregar a Favorite ${movie['title']}'),
      //   ),
      // );
      Fluttertoast.showToast(
        msg: "No se pudo Agregar a Favorite ${movie['title']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white70,
        fontSize: 16.0
      );
    }
    return "Accept";
  }
  Widget getCarousel(){
    return isLoading ? Center(child: CircularProgressIndicator(),) : CarouselSlider(
      options: CarouselOptions(
        height: 80.0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: false,
        initialPage: 0,
        enlargeCenterPage: false,
        viewportFraction: 3.0,
        aspectRatio: 16/9,
      ),
      items: casting.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: i['profile_path']!=null ? new NetworkImage("https://image.tmdb.org/t/p/w500/${i['profile_path']}")
                                      : Icon(Icons.person)
                          )
                      )),
                  new Text("${i['name']}",textScaleFactor: 1.0)
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
  @override
  void initState(){
    getCast();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text(movie['title']),
       ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 20),
          // height: MediaQuery.of(context).size.height-250,
          children: <Widget>[
              Container(
                padding: EdgeInsets.all(6.0),
                child: Image.network("https://image.tmdb.org/t/p/w500"+movie['backdrop_path'],),

              ),
              Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.center,
//                decoration: (color: Colors.grey[300]),
                child: Text(
                  "Sinapsis",
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  movie['overview'],
                  textAlign: TextAlign.justify,
                ),

              ),
              Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.center,
//                decoration: (color: Colors.grey[300]),
                child: Text(
                  "Fecha de estreno",
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  movie['release_date'],
                  textAlign: TextAlign.center,
                ),

              ),
              Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.center,
//                decoration: (color: Colors.grey[300]),
                child: Text(
                  "Casting",
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(6.0),
                child: getCarousel()
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red,),
                        tooltip: 'Agregar a Favorite',
                        onPressed: () {
                          addFavorite(context);
                        },
                      ),
                      Text('add to favorite', textScaleFactor: 1.0, style: TextStyle(color: Colors.red),)
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.shop, color: Colors.cyan[600]),
                        tooltip: 'comprar pelicula',
                        onPressed: () {
                          
                        },
                      ),
                      Text('buy movie', textScaleFactor: 1.0, style: TextStyle(color: Colors.cyan[600]),)
                    ],
                  ),
                ],
              ),
            ],
          ),
    );

  }

}