import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketItemMarket extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String place;
  final String hash;
  final String block;
  TicketItemMarket({this.image, this.title, this.description, this.place, this.hash, this.block});
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Row(
      children: <Widget>[
        new Center(
            child: new Image.network(this.image,
          width: 100,
          height: 135,
        )),
        new Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(this.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Color(0Xff27ae60))),
              new Padding(
                  padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  child: new Text(this.description)),
              new Padding(
                  padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  child: new Text(this.place)),
              new Padding(
                  padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  child: new Text('Hash: ${this.hash}')),
              new Padding(
                  padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                  child: new Text('Bloque: ${this.block}')),
            ],
          ),
        )
      ],
    ));
  }
}
