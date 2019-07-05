import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tickets/ui/feed/SwipeAnimation/dataCard.dart';

Positioned cardDemo(
    DataCardContent data,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    Function dismissImg,
    int flag) {
  Size screenSize = MediaQuery.of(context).size;
  return new Positioned(
    bottom: 120.0 + bottom,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Dismissible(
      key: new Key(new Random().toString()),
      crossAxisEndOffset: -0.3,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          dismissImg(data, false);
        } else {
          dismissImg(data, true);
        }
      },
      child: new Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform: new Matrix4.skewX(skew),
        //..rotateX(-math.pi / rotation),
        child: new RotationTransition(
          turns: new AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: new Hero(
            tag: "img",
            child: new GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     new MaterialPageRoute(
                //         builder: (context) => new DetailPage(type: img)));
                /*Navigator.of(context).push(new PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new DetailPage(type: img),
                )); */
              },
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
                          image: data.image,
                        ),
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
                                      padding:
                                          new EdgeInsets.only(bottom: 8.0)),
                                  new Text(data.summary,
                                      textAlign: TextAlign.start,
                                      style:
                                          new TextStyle(color: Colors.white)),
                                ],
                              )),
                        ),
                      ),
                      /* new Container(
                          width: screenSize.width / 1.2 + cardWidth,
                          height:
                              screenSize.height / 1.7 - screenSize.height / 2.2,
                          alignment: Alignment.center,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new FlatButton(
                                  padding: new EdgeInsets.all(0.0),
                                  onPressed: () {
                                    swipeLeft();
                                  },
                                  child: new Container(
                                    height: 60.0,
                                    width: 130.0,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          new BorderRadius.circular(60.0),
                                    ),
                                    child: new Text(
                                      "DON'T",
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                  )),
                              new FlatButton(
                                  padding: new EdgeInsets.all(0.0),
                                  onPressed: () {
                                    swipeRight();
                                  },
                                  child: new Container(
                                    height: 60.0,
                                    width: 130.0,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius:
                                          new BorderRadius.circular(60.0),
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
            ),
          ),
        ),
      ),
    ),
  );
}
