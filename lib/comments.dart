import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
void main() {
  runApp(new MaterialApp(
    //title: "My Store",
    home: new Comment(),
  ));
}
class Comment extends StatefulWidget {
  List list;
  int index;
  Comment({this.list, this.index});
  @override
  _CommentState createState() => new _CommentState();
}

class _CommentState extends State<Comment> {

 Future<List> getKomen() async {
    final response = await http.get("https://oopsie-movie.000webhostapp.com/webservices/get_komen.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder<List>(
        future: getKomen(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemComment(
                  list: snapshot.data,
                  idpostingan: widget.list[widget.index]['idpostingan'],
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
class ItemComment extends StatelessWidget {
  final List list;
  final idpostingan;
  ItemComment({this.list, this.idpostingan});
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      child: Stack(children: <Widget>[
        // Container(
        //   height: height * 0.55,
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: NetworkImage(
        //               'https://oopsie-movie.000webhostapp.com/penulis/Upload/Image/' +
        //                   '${list[index]['gambar']}'),
        //           fit: BoxFit.fitWidth)),
        // ),
        Container(
          width: width,
          margin: EdgeInsets.only(top: height * 0.5),
          // padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)),
          ),
          child: ListView.builder(
            itemCount: list == null ? 0 : list.length,
            itemBuilder: (context, index) {
              if (list[index]['idpostingan'] == idpostingan){
              return new Container(
                padding: const EdgeInsets.all(3.0),
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      Text(list[idpostingan]['isi']),]

                  ),
                ),
              );
            }
            else{
              return Container();
            }
            },
          ),
        ),
      ]),
    );
  }
}
