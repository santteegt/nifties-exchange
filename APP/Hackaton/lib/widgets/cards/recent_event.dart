import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RecentEventCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final String icon;
  final bool isActive;
  RecentEventCard({this.buttonName, this.icon, this.onPressed, this.isActive});
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: new Container(
          width: 240,
          child: new Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Image.network(
                    'https://imagenes.milenio.com/Y6d0Kn6PiaF18_A1wTaNtKEi4hc=/958x596/smart/https://www.milenio.com/uploads/media/2019/03/15/ilusionistas-continuaran-funciones-domingo-foto.jpeg'),
                new Padding(
                    padding:
                        new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('Blockchain Latam Submit 2019',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                        new Text('Teatro telcel, CDMX',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600])),
                        new Text('17 de Junio 2019 a las 8:30 P.M',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600])),
                        new Text('Cupo limitado - 200 Personas',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600])),
                      ],
                    )),
                new Divider(
                  color: Colors.grey[300],
                ),
                new Padding(
                  padding: EdgeInsets.only(),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          child: new Padding(
                              padding: EdgeInsets.all(5),
                              child: RichText(
                                  text: TextSpan(
                                text: 'Desde',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' \$400 MXN',
                                      style: TextStyle(
                                        color: Colors.blue[800],
                                          fontWeight: FontWeight.bold))
                                ],
                              )))),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      new Container(
                          child: IconButton(
                              color: Colors.grey[600],
                              onPressed: () => print('Hos'),
                              icon: new Icon(AntDesign.getIconData("sharealt")),
                              iconSize: 22)),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      new Container(
                          child: new Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: IconButton(
                            color: Colors.grey[600],
                            onPressed: () => print('Hos'),
                            icon: new Icon(AntDesign.getIconData("book")),
                            iconSize: 22),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
