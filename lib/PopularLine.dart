import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/ViewDetails.dart';
import 'package:movies_app/ApiProvider.dart';


class PopularLine extends StatefulWidget{
  bool internet;
  PopularLine(this.internet);
  @override
  State<StatefulWidget> createState() => PopularLineForm(internet);
}

class PopularLineForm extends State<PopularLine>{
  final String urlPopular="https://api.themoviedb.org/3/movie/popular?api_key=323f74918f363cfd35a67d3ea4a5316d&language=es-MX&page=1";
  final String urlAddFavorite="https://api.themoviedb.org/3/list/143905/add_item?api_key=323f74918f363cfd35a67d3ea4a5316d&session_id=0d0f33396cc0edd0999380e7ea3df066a039866a";
  bool internet;
  var isLoading=false;
  List movies;

  PopularLineForm(this.internet);
  
  Future<String> getPopulars() async{
    this.setState((){
      isLoading=true;
    });
    var response=await http.get(urlPopular,
      headers: {
        "Accept": "application/json",
      }
    );
    var apiProvider = ApiProvider();
    await apiProvider.getAllPopular();
    
    print('Status code: ${response.statusCode}');
    if(response.statusCode==200){
      this.setState((){
        isLoading=false;
        movies=convert.jsonDecode(response.body)['results'];
      });
    }else{
      movies=new List();
      this.setState((){
        isLoading=false;
      });
    }
    return "Accept";
  }
  Future<String> addFavorite(int index,BuildContext context) async{
    String bodyJSON='{ "media_id" : ${movies[index]['id']} }';
    var response=await http.post(urlAddFavorite,
      headers: {
        "Content-Type": "application/json;charset=utf-8",
      },
      body: bodyJSON
    );
    print('Status code: ${response.statusCode}');
    if(response.statusCode==201){
      // print('Se agrego exitosamente a Favortie');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${movies[index]['title']} Se añadio a Favortie'),
        ),
      );
    }else{
      // print('No se pudo Agregar a Favorite');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo Agregar a Favorite ${movies[index]['title']}'),
        ),
      );
    }
    return "Accept";
  }

  @override
  void initState(){
    getPopulars();
    super.initState();
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
                              padding: movies[index]['backdrop_path']!=null ? EdgeInsets.only(right: 5.0) : EdgeInsets.symmetric(horizontal: 27.0),
                              // decoration: BoxDecoration(
                              //   border: Border( right: BorderSide(width: 1.0, color: Colors.black))
                              // ),
                              child: movies[index]['backdrop_path']!=null ? Image.network("https://image.tmdb.org/t/p/w500"+movies[index]['backdrop_path'],) : Icon(Icons.photo, size: 50.00, color: Theme.of(context).textTheme.bodyText1.color,),
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
                      foregroundColor: Colors.red,
                      caption: 'add to favorite',
                      color: Colors.grey[850],
                      icon: Icons.favorite,
                      onTap: () => {
                        addFavorite(index, context)
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
                            builder: (context) => ViewDetails(movies[index], internet),
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