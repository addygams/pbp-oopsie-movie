import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oopsie/comments.dart';
import 'dart:async';
import 'dart:convert';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.list, this.index});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  Future<List> getKomen() async {
    final response = await http.get("https://oopsie-movie.000webhostapp.com/webservices/get_komen.php");
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Stack(
            children: <Widget>[
              Container(
                height: height * 0.55,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://oopsie-movie.000webhostapp.com/penulis/Upload/Image/' +
                              '${widget.list[widget.index]['gambar']}'
                        ),
                        fit: BoxFit.fitWidth)),
              ),
              Container(
                width: width,
                margin: EdgeInsets.only(top: height * 0.5),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.list[widget.index]['judul']}",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.people),
                        Text("  ${widget.list[widget.index]['namapenulis']}"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.movie),
                        Text("  ${widget.list[widget.index]['namakategori']}"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today),
                        Text("  ${widget.list[widget.index]['tgl']}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${widget.list[widget.index]['isi_post']}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.5,
                          wordSpacing: 1.5),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    
                          new FutureBuilder<List>(
                          future: getKomen(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);

                            return snapshot.hasData
                                ? new ItemComment(
                                    list: snapshot.data,
                                    idpostingan: widget.list[widget.index]['isi'],
                                  )
                                : new Center(
                                    child: new CircularProgressIndicator(),
                                  );
                          }
                        )
                  ],
                ),
              ),
            ],
          ),
        ),
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
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context,i){
        if (list[i]['idpostingan']==idpostingan){
          return Container(
            child: new Card(
              child: Container(
                child: new Container(
                  padding: const EdgeInsets.all(8),
                  child: new Text(list[i]['isi'],
                  style: new TextStyle(fontSize: 12)),
                ),
              ),
            )
          );
        } else {
          return Container();
        }
      }
    );
    // return Container(
    //   width: width,
    //   child: Stack(children: <Widget>[
    //     // Container(
    //     //   height: height * 0.55,
    //     //   decoration: BoxDecoration(
    //     //       image: DecorationImage(
    //     //           image: NetworkImage(
    //     //               'https://oopsie-movie.000webhostapp.com/penulis/Upload/Image/' +
    //     //                   '${list[index]['gambar']}'),
    //     //           fit: BoxFit.fitWidth)),
    //     // ),
    //     Container(
    //       width: width,
    //       margin: EdgeInsets.only(top: height * 0.5),
    //       // padding: EdgeInsets.all(30),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(30),
    //             topRight: Radius.circular(30)),
    //       ),
    //       child: ListView.builder(
    //         itemCount: list == null ? 0 : list.length,
    //         itemBuilder: (context, index) {
    //           if (list[index]['idpostingan'] == idpostingan){
    //           return new Container(
    //             padding: const EdgeInsets.all(3.0),
    //             child: new Card(
    //               child: new Column(
    //                 children: <Widget>[
    //                   Text(list[idpostingan]['isi']),]

    //               ),
    //             ),
    //           );
    //         }
    //         else{
    //           return Container();
    //         }
    //         },
    //       ),
    //     ),
    //   ]),
    // );
  }
}
