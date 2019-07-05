import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tickets/style/theme.dart' as Theme;

class TicketWidget extends StatelessWidget {
  final String title;
  final String place;
  final String hash;
  final Color color;
  final bool available;
  final String date;
  TicketWidget({this.title, this.date, this.place, this.available, this.hash, this.color});
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 7.0),
        child: new Container(
          height: 116.0,
          child: new Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                    padding:
                        new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    child: new Stack(
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(this.title,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                            new Container(height: 4.0),
                            new Text(this.hash,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.Colors.loginGradientStart)),
                            new Container(height: 2.0),
                            new Text(this.place,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600])),
                            new Container(height: 4.0),
                            new Text(this.date,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600]))
                          ],
                        ),
                        new Positioned(
                          child: new Align(
                              alignment: Alignment.topRight,
                              child: new Column(
                                children: <Widget>[
                                  new Text(this.available ? 'Disponible': 'Usado',
                                      style: TextStyle(
                                          color: this.available ? this.color : Colors.red,
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w500))
                                ],
                              )),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
