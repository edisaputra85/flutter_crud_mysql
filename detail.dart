import 'package:flutter/material.dart';
import 'package:crud_mysql/editdata.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = "http://10.0.2.2/my_store/deletedata.php";
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
    }).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are You sure want to delete '${widget.list[widget.index]['item_name']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("OK DELETE!"),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Home(),
            ));
          },
        ), //Kembali ke Home
        new RaisedButton(
          child: new Text("CANCEL"),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: new Text("${widget.list[widget.index]['item_name']}")),
        body: new Container(
            padding: EdgeInsets.all(20.0),
            height: 250.0,
            child: new Card(
                color: Colors.blue[50],
                child: new Center(
                    child: new Column(children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 30.0)),
                  new Text("${widget.list[widget.index]['item_name']}",
                      style: new TextStyle(fontSize: 20.0)),
                  new Text("Code  : ${widget.list[widget.index]['item_code']}",
                      style: new TextStyle(fontSize: 18.0)),
                  new Text("Price : ${widget.list[widget.index]['price']}",
                      style: new TextStyle(fontSize: 18.0)),
                  new Text("Stok  : ${widget.list[widget.index]['stock']}",
                      style: new TextStyle(fontSize: 18.0)),
                  new Padding(padding: const EdgeInsets.only(top: 30.0)),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new RaisedButton(
                          child: new Text("EDIT"),
                          color: Colors.green,
                          onPressed: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new EditData(
                                  index: widget.index,
                                  list: widget
                                      .list), //penggunaan widget.list karena argumen list bukan berada pada class state
                            ),
                          ),
                        ),
                        new RaisedButton(
                          child: new Text("DELETE"),
                          color: Colors.red,
                          onPressed: () => confirm(),
                        )
                      ])
                ])))));
  }
}
