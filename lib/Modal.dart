import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Modal {

  static void showModal(BuildContext context, List movies, int index) {
    Dialog dialogWithImage = Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height-250,
        width: 400.0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Text(
                movies[index]['title'],
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Image.network("https://image.tmdb.org/t/p/w500"+movies[index]['backdrop_path'],),

            ),
            Container(
              padding: EdgeInsets.all(9.0),
              child: Text(
                movies[index]['overview'],
                textAlign: TextAlign.justify,
              ),

            ),
            Container(
              padding: EdgeInsets.all(9.0),
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
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }
}
