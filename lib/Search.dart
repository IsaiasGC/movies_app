import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget{
  const Search({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchForm();
}

class SearchForm extends State<Search>{
  List movies;
  _MySearchDelegate _delegate;
  


  @override
  void initState() {
    super.initState();
    _delegate = _MySearchDelegate(movies);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Text('Search Movies'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String selected = await showSearch<String>(
                context: context,
                delegate: _delegate,
              );
              if (selected != null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You have selected the word: $selected'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Center(),
    );
  }
}


// Defines the content of the search page in showSearch().
// SearchDelegate has a member query which is the query string.
class _MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;
  var isLoading=false;
  List movies;
  final String urlAddFavorite="https://api.themoviedb.org/3/list/143905/add_item?api_key=323f74918f363cfd35a67d3ea4a5316d&session_id=0d0f33396cc0edd0999380e7ea3df066a039866a";

  _MySearchDelegate(List<String> words)
      : _words = words,
        _history = <String>['apple', 'hello', 'world', 'flutter'],
        super();

  Future<String> searchMovie(String query) async{
    query.replaceAll(' ', '%');
    var response=await http.get('https://api.themoviedb.org/3/search/movie?api_key=323f74918f363cfd35a67d3ea4a5316d&language=es-MX&query=$query&page=1&include_adult=false',
      headers: {
        "Content-Type": "application/json;charset=utf-8",
      }
    );
    print('Status code: ${response.statusCode}');
    if(response.statusCode==201){
      print('Se agrego exitosamente a Favortie');
    }else{
      print('No se pudo Agregar a Favorite');
    }
    return "Accept";
  }
  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Search Results:'),
            GestureDetector(
              onTap: () {
                // Returns this.query as result to previous screen, c.f.
                // showSearch() above.
                searchMovie(this.query);
                this.close(context, this.query);
              },
              child: ListView.builder(
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
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        //Icon(Icons.touch_app, color: Colors.yellowAccent),
                                        Text(movies[index]['release_date'], style: TextStyle(color: Colors.black))
                                      ],
                                    ),
                                    // trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 30.0,),
                                    onTap: (){
                                      this.query=movies[index]['id'];
                                    },
                                  ),
                                ),
                          ),
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((word) => word.startsWith(query));

    return _SuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        this._history.insert(0, suggestion);
        showResults(context);
      },
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
                this.query = 'TODO: implement voice input';
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
// Suggestions list widget displayed in the search page.
class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}