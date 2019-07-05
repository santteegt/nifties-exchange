import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tickets/presenter/presenter.dart';
import 'package:tickets/style/theme.dart' as Theme;

class Contact extends StatefulWidget {
  Contact({Key key}) : super(key: key);
  @override
  ContactState createState() => ContactState();
}

class ContactState extends State<Contact> implements APIResult {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Contáctanos', style: TextStyle(fontWeight: FontWeight.w400)),
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
      body: new Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: new Column(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(25.0),
            child: new Text('Introduce en los isguientes campos tus dudas o problemas con Smartpass',
            style: TextStyle(fontSize: 16.0)),
          ),
          new Card(
            child: new Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  cursorColor: Colors.grey[600],
                  style: TextStyle(color: Colors.grey[600]),
                  onChanged: (value) {},
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Para: info@katun.tech',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon:
                        Icon(Icons.email, color: Colors.grey[600], size: 16),
                    border: InputBorder.none,
                  ),
                )),
          ),
          new Container(height: 5.0),
          new Card(
            child: new Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  cursorColor: Colors.grey[600],
                  style: TextStyle(color: Colors.grey[800]),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Asunto',
                    prefixStyle: TextStyle(color: Colors.grey[600]),
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon:
                        Icon(Icons.comment, color: Colors.grey[600], size: 16),
                    border: InputBorder.none,
                  ),
                )),
          ),
          new Container(height: 5.0),
          new Card(
            child: new Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  cursorColor: Colors.grey[600],
                  style: TextStyle(color: Colors.grey[800]),
                  onChanged: (value) {},
                  maxLines: 13,
                  decoration: InputDecoration(
                    hintText: 'Mensaje',
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none,
                  ),
                )),
          ),
          new Container(
                margin: EdgeInsets.only(top: 25.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                  height: 55.0,
                  width: 250.0,
                  child: new MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Theme.Colors.loginGradientEnd,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "Enviar",
                          style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                      onPressed: () => {}),
                ),
              )
        ]
      )
      )
    );
  }

  @override
  void onError(DioError err) {
    print(err.type);
    if (err.type == DioErrorType.CONNECT_TIMEOUT ||
        err.type == DioErrorType.RECEIVE_TIMEOUT) {
    } else {}
  }

  @override
  void onResult(value) {}
}
