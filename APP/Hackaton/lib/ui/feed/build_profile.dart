import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:tickets/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tickets/ui/principal/principal.dart';

class BuildProfile extends StatefulWidget {
  BuildProfile({Key key}) : super(key: key);
  @override
  BuildProfileState createState() => BuildProfileState();
}

class BuildProfileState extends State<BuildProfile> {
  bool _isLoading = true;
  Timer _timer;
  String _image = 'assets/img/t.gif';
  String _message = 'Generando perfil, por favor espera...';

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  next() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Principal()),
      (Route<dynamic> route) => false,
    );
  }

  startTimer() {
    _timer = new Timer(const Duration(milliseconds: 6000), () {
      setState(() {
        _isLoading = false;
        _message = 'Tu cuenta ha sido creada, es hora de iniciar!';
        _image = 'assets/img/done.gif';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Widget _continueButton = new Padding(
      padding: EdgeInsets.only(top: 30),
      child: new SpinKitRipple(color: Color(0xFF40739e)),
    );
    if (!_isLoading)
      _continueButton = new Container(
        margin: EdgeInsets.only(top: height / 5),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.Colors.loginGradientStart,
              offset: Offset(1.0, 6.0),
              blurRadius: 10.0,
            )
          ],
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
                  "Comencemos",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
              onPressed: next),
        ),
      );
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        appBar: new AppBar(
            brightness: Brightness.light,
            title: Text('', style: TextStyle(color: Color(0xFF535353))),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Color(0xFF535353)),
            elevation: 0.0,
            centerTitle: true),
        body: new SingleChildScrollView(
            child: new Container(
          child: new Column(
            children: <Widget>[
              new Center(
                  child: new Padding(
                padding: EdgeInsets.only(left: 23.0, right: 23.0, top: 30.0),
                child: new Image.asset(_image, width: 320, height: 320),
              )),
              new Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 40),
                child: new Text(_message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF2c3e50),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400)),
              ),
              new Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: _continueButton),
            ],
          )
        )));
  }
}
