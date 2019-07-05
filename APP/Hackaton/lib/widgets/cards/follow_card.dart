import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'package:tickets/widgets/button/button_color.dart';

typedef OnLinkedIn(String url);

class FollowCard extends StatelessWidget {
  final VoidCallback onPressed;
  final OnLinkedIn action;
  final String name;
  final String img;
  final String url;
  FollowCard({this.onPressed, this.name, this.img, this.action, this.url});
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: new Container(
          width: 150,
          child: new Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Center(
                    child: new Container(
                        width: 75,
                        height: 75,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(this.img),
                          backgroundColor: Colors.transparent,
                        ))),
                new Padding(
                    padding:
                        new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    child: new Center(
                        child: new Column(
                      children: <Widget>[
                        new Text(this.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        new Padding(
                          padding: prefix0.EdgeInsets.all(10.0),
                          child: new ButtonColor(
                                    buttonName: 'Seguir',
                                    icon: "plus",
                                    height: 30,
                                    color: Color(0xFF273c75),
                                    onPressed: () => this.action(this.url),
                                  )
                        )
                        ],
                    ))),
              ],
            ),
          ),
        ));
  }
}
