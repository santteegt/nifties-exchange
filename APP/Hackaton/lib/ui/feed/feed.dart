import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:tickets/presenter/presenter.dart';
import 'package:flutter/material.dart';
import 'package:tickets/ui/feed/SwipeAnimation/dataCard.dart';
import 'package:tickets/ui/feed/SwipeAnimation/activeCard.dart';
import 'package:tickets/ui/feed/SwipeAnimation/dummyCard.dart';

import 'build_profile.dart';

class SwipeFeedPage extends StatefulWidget {
  @override
  _SwipeFeedPageState createState() => new _SwipeFeedPageState();
}

class _SwipeFeedPageState extends State<SwipeFeedPage>
    with TickerProviderStateMixin
    implements APIResult {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  bool _isLoading = true;
  int flag = 0;
  bool feedDone = false;
  DataCardContent currentItem;
  List<DataCardContent> data = new List();
  List<String> likes = new List();

  List selectedData = [];
  void initState() {
    super.initState();
    ApiPresenter(this, 'getGenres', null).exec();
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation(bool isLike) async {
    try {
      await _buttonController.forward();
      dismissImg(currentItem, isLike);
    } on TickerCanceled {}
  }

  dismissImg(DataCardContent img, bool isLike) {
    if (isLike) likes.add(currentItem.title);
    setState(() {
      data.remove(img);
    });
    if (data.length == 0) {
      setState(() {
        feedDone = true;
        _isLoading = true;
      });
      ApiPresenter(this, 'saveFeed', {'data': likes}).exec();
    }
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation(true);
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation(false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return new Scaffold(
          body: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CircularProgressIndicator())));
    else {
      timeDilation = 0.4;
      double initialBottom = 15.0;
      var dataLength = data.length;
      double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
      double backCardWidth = -10.0;
      return (new Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: new Text('Feed Events',
                style: TextStyle(color: Color(0xFF273c75))),
            actions: <Widget>[
              new IconButton(
                  onPressed: () {},
                  icon: new Icon(Icons.help, color: Colors.grey)),
            ],
          ),
          body: new Stack(
            children: <Widget>[
              new Align(
                child: new Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 10.0, bottom: 20.0),
                  child: new Text(
                    'Selecciona los eventos que más te interesan, generaremos recomendaciones de acuerdo a tu selección',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                alignment: Alignment.topCenter,
              ),
              new Align(
                child: new Container(
                  child: dataLength > 0
                      ? new Stack(
                          alignment: AlignmentDirectional.center,
                          children: data.map((item) {
                            if (data.indexOf(item) == dataLength - 1) {
                              currentItem = item;
                              return cardDemo(
                                  item,
                                  bottom.value,
                                  right.value,
                                  0.0,
                                  backCardWidth + 10,
                                  rotate.value,
                                  rotate.value < -10 ? 0.1 : 0.0,
                                  context,
                                  dismissImg,
                                  flag);
                            } else {
                              backCardPosition = backCardPosition - 10;
                              backCardWidth = backCardWidth + 10;

                              return cardDemoDummy(item, backCardPosition, 0.0,
                                  0.0, backCardWidth, 0.0, 0.0, context);
                            }
                          }).toList())
                      : new Text("No Event Left",
                          style: new TextStyle(
                              color: Colors.white, fontSize: 50.0)),
                ),
                alignment: Alignment.center,
              ),
              new Align(
                child: buttonsRow(),
                alignment: Alignment.bottomCenter,
              ),
            ],
          )));
    }
  }

  Widget buttonsRow() {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 68.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Padding(padding: new EdgeInsets.only(right: 8.0)),
          new FloatingActionButton(
            onPressed: () => swipeLeft(),
            heroTag: 1,
            backgroundColor: Colors.white,
            child: new Icon(Icons.close, color: Color(0xFF273c75)),
          ),
          new Padding(padding: new EdgeInsets.only(right: 10.0)),
          new FloatingActionButton(
            onPressed: () => swipeRight(),
            heroTag: 0,
            backgroundColor: Colors.white,
            child: new Icon(Icons.favorite, color: Colors.red),
          ),
          new Padding(padding: new EdgeInsets.only(right: 8.0)),
        ],
      ),
    );
  }

  @override
  void onError(DioError err) {
    if (err.type == DioErrorType.CONNECT_TIMEOUT ||
        err.type == DioErrorType.RECEIVE_TIMEOUT) {
      if (feedDone == true)
        ApiPresenter(this, 'saveFeed', {'data': likes}).exec();
      else
        ApiPresenter(this, 'getGenres', null).exec();
    }
  }

  @override
  void onResult(value) {
    switch (value['method']) {
      case 'feed':
        value['data'].forEach((item) {
          data.add(new DataCardContent(
              image: new DecorationImage(
                image: new NetworkImage(item['img']),
                fit: BoxFit.cover,
              ),
              title: item['name'],
              summary: item['description']));
        });
        setState(() {
          _isLoading = false;
        });
        break;
      case 'feed_done':
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BuildProfile()),
          (Route<dynamic> route) => false,
        );
        break;
    }
  }
}
