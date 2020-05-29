import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/ViewDetails.dart';


class Favorite extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return FavoriteForm();
  }
}

class FavoriteForm extends State<Favorite>{
  final String urlFavorite="https://api.themoviedb.org/3/list/143905?api_key=323f74918f363cfd35a67d3ea4a5316d&language=es-MX";
  final String urlDeleteItem="https://api.themoviedb.org/3/list/143905/remove_item?api_key=323f74918f363cfd35a67d3ea4a5316d&session_id=0d0f33396cc0edd0999380e7ea3df066a039866a";
  var isLoading=false;
  List movies;
  
  Future<String> getFavorite() async{
    this.setState((){
      isLoading=true;
    });
    var response=await http.get(urlFavorite,
      headers: {
        "Accept": "application/json",
      }
    );
    print('Status code: ${response.statusCode}');
    if(response.statusCode==200){
      this.setState((){
        isLoading=false;
        movies=convert.jsonDecode(response.body)['items'];
      });
    }else{
      movies=new List();
      this.setState((){
        isLoading=false;
      });
    }
    return "Accept";
  }
  Future<String> removeItem(int index) async{
    String bodyJSON='{ "media_id" : ${movies[index]['id']} }';
    var response=await http.post(urlDeleteItem,
      headers: {
        "Content-Type": "application/json;charset=utf-8",
      },
      body: bodyJSON
    );
    print('Status code: ${response.statusCode}');
    if(response.statusCode==200){
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${movies[index]['title']} Se Elimino de Favortie'),
        ),
      );
      getFavorite();
    }else{
      print('No se pudo Eliminar');
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo Eliminar de Favorite ${movies[index]['title']}'),
        ),
      );
    }
    return "Accept";
  }

  @override
  void initState(){
    getFavorite();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(title: Text('Favorite'),),
      body: isLoading ? Center(child: CircularProgressIndicator(),)
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
                              movies[index]['name']!=null ? movies[index]['name'] : movies[index]['title'],
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                //Icon(Icons.touch_app, color: Colors.yellowAccent),
                                Text(movies[index]['media_type'], style: TextStyle(color: Colors.black))
                              ],
                            ),
                            // trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0,),
                          ),
                        ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'quit of favorite',
                      color: Color.fromARGB(255, 189, 50, 10),
                      icon: Icons.favorite_border,
                      onTap: () => {
                        removeItem(index)
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
      ),
    );
  }
}