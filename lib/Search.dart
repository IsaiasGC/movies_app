import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/ViewDetails.dart';

class Search extends StatelessWidget{

  Future<String> viewMovie(String id, context) async{
    var url='https://api.themoviedb.org/3/movie/$id?api_key=323f74918f363cfd35a67d3ea4a5316d&language=es-MX';
    Map<String, dynamic> movie;
    var response=await http.get(url,
      headers: {
        "Accept": "application/json",
      }
    );
    print('Status code: ${response.statusCode}');
    if(response.statusCode==200){
        movie=convert.jsonDecode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
//            builder: (context) => ViewDetails(movie),
          ),
        );
    }else{
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Osurrio unerror: no se pudo cargar la pelicula'),
        ),
      );
    }
    return "Accept";
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movie'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () async {
              final String selected = await showSearch<String>(
                context: context, 
                delegate: DataSearch()
              );
              if (selected != null) {
                viewMovie(selected, context);
              }
          })
        ],
      ),
    );
  }
}


// Defines the content of the search page in showSearch().
// SearchDelegate has a member query which is the query string.
class DataSearch extends SearchDelegate<String> {
  final List history;
  List movies;
  BuildContext context;

  DataSearch()
      : history = <String>['apple', 'hello', 'world', 'flutter'],//obtener historial
        super();
  
  Future<String> searchMovie(String query) async{
    movies=new List();
    query.replaceAll(' ', '%');
    var response=await http.get('https://api.themoviedb.org/3/search/movie?api_key=323f74918f363cfd35a67d3ea4a5316d&language=es-MX&query=$query&page=1&include_adult=false',
      headers: {
        "Accept": "application/json",
      }
    );
    print('Status code: ${response.statusCode}');
    if(response.statusCode==200){
      movies=convert.jsonDecode(response.body)['results'];
    }else{
      print('No se encontraron similitudes');
    }
    return 'Accept';
  }
  
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }
  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    this.context=context;
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        this.close(context, null);
      },
    );
  }

  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: movies==null? 0: movies.length,
      itemBuilder: (context, index) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.5),
        leading: Container(
          padding: movies[index]['backdrop_path']!=null ? EdgeInsets.only(right: 5.0) : EdgeInsets.symmetric(horizontal: 27.0),
          child: movies[index]['backdrop_path']!=null ? Image.network("https://image.tmdb.org/t/p/w500"+movies[index]['backdrop_path'],)
                        : Icon(Icons.photo, size: 50.00,),
        ),
        title: Text(
          movies[index]['title'],
          style: TextStyle(color: Colors.black),
        ),
        onTap: (){
          this.query='${movies[index]['id']}';
          this.close(context, this.query);
        },
      ),
    );
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionList=history;
    // final bool search=this.query.isNotEmpty;
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
        title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey)
                ),
              ],
            ),
        ),
        onTap: (){
          this.query= suggestionList[index];
          searchMovie(this.query).then((value) => this.showResults(this.context));
          // this.close(context, this.query);
        },
      ),
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                // this.query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}