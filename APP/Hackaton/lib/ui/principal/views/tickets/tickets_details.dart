import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tickets/style/theme.dart' as Theme;
import 'package:tickets/ui/feed/feed.dart';
import 'package:tickets/widgets/separators/dash_line.dart';

class TicketsDetails extends StatefulWidget {
  TicketsDetails({Key key}) : super(key: key);
  @override
  TicketsDetailsState createState() => TicketsDetailsState();
}

class TicketsDetailsState extends State<TicketsDetails>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  next() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SwipeFeedPage()));
  }

  resend() {}

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Detalles del ticket',
              style: TextStyle(fontWeight: FontWeight.w400)),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientEnd,
                    Theme.Colors.loginGradientStart
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                  padding: new EdgeInsets.only(top: 16.0, bottom: 8.0),
                  width: double.infinity,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border(
                          bottom: new BorderSide(color: Colors.black12))),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text('Titulo principal del evento',
                                  textAlign: TextAlign.right,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17))
                            ],
                          )),
                      new Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 3, left: 20, right: 20),
                          child: new Column(
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(bottom: 3.5),
                                      child: new Icon(
                                          AntDesign.getIconData("pushpino"),
                                          color: Color(0xFFa0a2ae),
                                          size: 15)),
                                  new Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: new Text(
                                          ' Nexahualcoyotl, Estado de Mèxico',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.grey[600])))
                                ],
                              )
                            ],
                          )),
                      new Padding(
                          padding: EdgeInsets.only(
                              top: 2.0, bottom: 3, left: 20, right: 20),
                          child: new Column(
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Padding(
                                      padding: EdgeInsets.only(bottom: 3.5),
                                      child: new Icon(
                                          AntDesign.getIconData("calendar"),
                                          color: Color(0xFFa0a2ae),
                                          size: 15)),
                                  new Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: new Text(
                                          ' Miercoles, 1 de Julio - a las 9:00 p.m',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.grey[600])))
                                ],
                              )
                            ],
                          )),
                      new Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: new DashLine(
                          color: Colors.grey[400],
                          height: 1.0,
                        ),
                      ),
                      new Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20.0, bottom: 3),
                          child: new Text('Tipo de ticket',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.grey[600]))),
                      new Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 5.0, bottom: 10.0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Tipo de boleto vip',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                  text: '   x   ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600]),
                                ),
                                TextSpan(
                                    text: '1',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: '   x   ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600])),
                                TextSpan(
                                    text: '\$100',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          )),
                      new Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: new DashLine(
                          color: Colors.grey[400],
                          height: 1.0,
                        ),
                      ),
                      new Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 20.0, bottom: 3),
                          child: new Text('Precio total',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.grey[600]))),
                      new Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10.0, bottom: 15.0),
                          child: new Text('\$100.00 mxn',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.black)))
                    ],
                  )),
              new Container(height: 15),
              new Container(
                  padding: new EdgeInsets.only(top: 16.0, bottom: 8.0),
                  width: double.infinity,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border(
                          bottom: new BorderSide(color: Colors.black12))),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 10.0, bottom: 0.0),
                          child: new Text('Hash de registro',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.grey[600]))),
                      new Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 0.0, bottom: 2.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text('0xFE343RENIUBD2...',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black)),
                              new Padding(
                                padding: EdgeInsets.only(bottom: 3.0),
                                child: new FlatButton(
                                  onPressed: () => {},
                                  child: new Text('Ver en explorador',
                                      style: TextStyle(
                                          color: Theme.Colors.loginGradientEnd,
                                          decoration:
                                              TextDecoration.underline)),
                                ),
                              )
                            ],
                          )),
                      new Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: new DashLine(
                            color: Colors.grey[400],
                            height: 1.0,
                          )),
                      new Center(
                        child: new Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Image.network(
                              'http://product.corel.com/help/Common/CDGS/540223850/Shared/CorelDRAW-QR-code.png',
                              width: 200,
                              height: 200),
                        ),
                      ),
                      new Center(
                        child: new Padding(
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 10.0, bottom: 15.0),
                          child: new Text('Por favor, muestre el código qr y la pantalla en la puerta para validar su entrada',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.grey[600]))),
                      ),
                      new Padding(
                          padding: EdgeInsets.only(top: 15.0,bottom: 10.0),
                          child: new DashLine(
                            color: Colors.grey[400],
                            height: 1.0,
                          )),
                      new Padding(
                        padding: EdgeInsets.only(left: 30, right: 30, top: 20.0, bottom: 20.0),
                        child: new Container(
                          height: 50.0,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            
                            gradient: new LinearGradient(
                                colors: [
                                  Theme.Colors.loginGradientEnd,
                                  Theme.Colors.loginGradientStart
                                ],
                                begin: const FractionalOffset(0.2, 0.2),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: new Container(
                            height: Platform.isAndroid ? 65.0 : 80,
                            width: double.maxFinite,
                            child: new MaterialButton(
                                highlightColor: Colors.transparent,
                                splashColor: Theme.Colors.loginGradientEnd,
                                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 42.0),
                                  child: Text(
                                    'Guardar mi ticket',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                onPressed: () => {}),
                          ),
                        ),
                      )
                    ],
                  )),
              new Container(height: 20),
            ],
          ),
        ));
  }
}
