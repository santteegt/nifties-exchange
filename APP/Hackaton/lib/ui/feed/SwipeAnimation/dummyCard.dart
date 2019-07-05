import 'package:flutter/material.dart';

import 'dataCard.dart';

Positioned cardDemoDummy(
    DataCardContent data,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  // Size screenSize=(500.0,200.0);
  // print("dummyCard");
  return new Positioned(
    bottom: 120.0 + bottom,
    // right: flag == 0 ? right != 0.0 ? right : null : null,
    //left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Card(
      color: Colors.transparent,
      elevation: 4.0,
      child: new Container(
        alignment: Alignment.center,
        width: screenSize.width / 1.35 + cardWidth,
        height: screenSize.height / 1.75,
        decoration: new BoxDecoration(
          color: new Color(0xFFFFFFFF),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Column(
          children: <Widget>[
            new Container(
                width: screenSize.width / 1.35 + cardWidth,
                height: screenSize.height / 1.75,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(
                        topLeft: new Radius.circular(8.0),
                        topRight: new Radius.circular(8.0)),
                    image: data.image),
                child: new Align(
                  alignment: Alignment.bottomLeft,
                  child: new Container(
                      padding: new EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(data.title,
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700)),
                          new Padding(
                              padding: new EdgeInsets.only(bottom: 8.0)),
                          new Text(data.summary,
                              textAlign: TextAlign.start,
                              style: new TextStyle(color: Colors.white)),
                        ],
                      )),
                )),
            /* new Container(
                width: screenSize.width / 1.2 + cardWidth,
                height: screenSize.height / 1.7 - screenSize.height / 2.2,
                alignment: Alignment.center,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FlatButton(
                        padding: new EdgeInsets.all(0.0),
                        onPressed: () {},
                        child: new Container(
                          height: 60.0,
                          width: 130.0,
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: new BorderRadius.circular(60.0),
                          ),
                          child: new Text(
                            "DON'T",
                            style: new TextStyle(color: Colors.white),
                          ),
                        )),
                    new FlatButton(
                        padding: new EdgeInsets.all(0.0),
                        onPressed: () {},
                        child: new Container(
                          height: 60.0,
                          width: 130.0,
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: new BorderRadius.circular(60.0),
                          ),
                          child: new Text(
                            "I'M IN",
                            style: new TextStyle(color: Colors.white),
                          ),
                        ))
                  ],
                )) */
          ],
        ),
      ),
    ),
  );
}
