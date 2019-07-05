import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:tickets/presenter/presenter.dart';
import 'package:tickets/style/theme.dart' as Theme;
import 'package:tickets/ui/feed/feed.dart';
import 'package:tickets/utils/storage/storage.dart';

class EmailValidation extends StatefulWidget {
  EmailValidation({Key key}) : super(key: key);
  @override
  EmailValidationState createState() => EmailValidationState();
}

class EmailValidationState extends State<EmailValidation> implements APIResult {
  Timer _timer;
  String _counterMessage = 'Reenviar en 30 segundos';
  String _email = '';
  String _pinCorrect = '';
  bool _canResend = false;
  bool _isCorrect = false;
  bool _showCorrect = false;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    setEmail();
    ApiPresenter(this, 'validEmail', null).exec();
    startTimer();
  }

  setEmail() async {
    String temp = await Storage().getString('email');
    setState(() {
      _email = temp;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  next() {
    if (_isCorrect) ApiPresenter(this, 'setValidEmail', null).exec();
  }

  resend() {
    if (_canResend) {
      _start = 30;
      _canResend = false;
      startTimer();
      ApiPresenter(this, 'validEmail', null).exec();
    }
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
                setState(() {
                  _canResend = true;
                  _counterMessage = 'Reenviar código';
                });
              } else {
                _start -= 1;
                _counterMessage = "Reenviar en $_start segundos";
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        appBar: new AppBar(
            brightness: Brightness.light,
            title: Text('Valida tu email',
                style: TextStyle(color: Theme.Colors.loginGradientEnd)),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Theme.Colors.loginGradientEnd),
            elevation: 0.0,
            centerTitle: true),
        body: new Center(
          child: new Container(
            height: double.maxFinite,
            child: new Stack(
              //alignment:new Alignment(x, y)
              children: <Widget>[
                new Positioned(
                    child: new Column(
                  children: <Widget>[
                    new Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                        child: new RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            text: 'Hemos enviado un email a ',
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xFF1e272e)),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: ' $_email ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.Colors.loginGradientEnd)),
                              new TextSpan(
                                  text:
                                      'con un código de 6 digitos, escribe el código en los siguientes campos'),
                            ],
                          ),
                        )),
                    new Padding(
                        padding: const EdgeInsets.only(
                            left: 40.0, right: 40.0, top: 0.0),
                        child: Center(
                          child: PinPut(
                            clearButtonIcon: new Icon(Icons.backspace,
                                size: 21, color: Color(0xFF535c68)),
                            pasteButtonIcon:
                                new Icon(Icons.content_paste, size: 20),
                            textStyle: TextStyle(fontSize: 20),
                            fieldsCount: 6,
                            onSubmit: (String pin) {
                              if (pin == _pinCorrect)
                                setState(() {
                                  _isCorrect = true;
                                  _showCorrect = false;
                                });
                              else
                                setState(() {
                                  _isCorrect = false;
                                  _showCorrect = true;
                                });
                            },
                          ),
                        )),
                    new Padding(
                        padding: const EdgeInsets.only(),
                        child: new AnimatedOpacity(
                            opacity: _showCorrect ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 400),
                            child: new Text('Código incorrecto',
                                style: TextStyle(color: Color(0xFFe74c3c))))),
                    new Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: new AnimatedOpacity(
                          opacity: _isCorrect ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 700),
                          child: new FloatingActionButton(
                            onPressed: next,
                            backgroundColor: Colors.white,
                            child: new Icon(Icons.check, color: Colors.teal),
                          )),
                    )
                  ],
                )),
                _isCorrect == false
                    ? new Positioned(
                        child: new Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: new Padding(
                              padding: EdgeInsets.only(),
                              child: new Container(
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(27.0),
                                      topRight: Radius.circular(27.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Theme.Colors.loginGradientStart,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 20.0,
                                    ),
                                    BoxShadow(
                                      color: Theme.Colors.loginGradientEnd,
                                      offset: Offset(1.0, 6.0),
                                      blurRadius: 5.0,
                                    ),
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
                                        _counterMessage,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    onPressed: resend,
                                  ),
                                ),
                              ),
                            )))
                    : new Text('')
              ],
            ),
          ),
        ));
  }

  @override
  void onError(DioError err) {
    print(err.response);
  }

  @override
  void onResult(value) {
    switch (value['method']) {
      case 'code':
        _pinCorrect = value['code'];
        break;
      case 'email_set':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SwipeFeedPage()));
        break;
    }
  }
}
