import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tickets/model/address.dart';
import 'package:tickets/model/user.dart';
import 'package:tickets/style/theme.dart' as Theme;
import 'package:tickets/ui/principal/views/profile/conditions.dart';
import 'package:tickets/ui/principal/views/profile/contact.dart';
import 'package:tickets/ui/principal/views/tickets/ticket_test.dart';
import 'package:tickets/utils/auth/token.dart';
import 'package:tickets/widgets/list/item_settings.dart';
import 'package:tickets/widgets/separators/dash_line.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  final Address address;
  final User user;
  Profile({Key key, this.user, this.address}) : super(key: key);
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  viewTicketsDetails() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TicketsDetailsT()));
  }

  void showInSnackBar(String value) {
    Toast.show(value, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red[400],
        backgroundRadius: 10);
  }

  void logout() {
    new Token().deleteToken();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
  }

  String _getName() {
    List<String> names = widget.user.name.split(' ');
    if (names.length > 2) return '${names[0]} ${names[1]}';
    if (names.length == 0) return '${names[0]}';
    if (names.length == 1) return '${names[0]}';
    return '';
  }

  void goToContact() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Contact()));
  }

  void goConditions() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Conditions()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            height: 230,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.Colors.loginGradientStart,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 20.0,
                ),
                BoxShadow(
                  color: Theme.Colors.loginGradientEnd,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 20.0,
                ),
              ],
              gradient: new LinearGradient(
                  colors: [Color(0Xff27ae60), Color(0Xff87e2ad)],
                  begin: const FractionalOffset(0.2, 0.2),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: new Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(top: 70),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  'Perfil',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24,
                                      letterSpacing: -0.9),
                                ),
                                new Container(height: 5.0),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Bienvenido,  ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15)),
                                      TextSpan(
                                          text: _getName(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {},
                                  child: new Icon(
                                    AntDesign.getIconData("bells"),
                                    color: Colors.white,
                                    size: 16.0,
                                  ),
                                  shape: new CircleBorder(),
                                  color: Colors.black12,
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: new Container(
                                      width: 55,
                                      height: 55,
                                      child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(
                                            widget.user.profileImg),
                                        backgroundColor: Colors.transparent,
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: new Container(
                          width: double.infinity,
                          height: 60,
                          decoration: new BoxDecoration(
                              color: Colors.black26,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Center(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('0',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    new Text('Eventos',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                ),
                              ),
                              new Container(
                                width: 1,
                                height: 40,
                                color: Colors.white30,
                              ),
                              new Center(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('1',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    new Text('Tickets',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white30,
                              ),
                              new Center(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('0',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    new Text('Siguiendo',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ])),
          ),
          new Expanded(
              child: new ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              new Container(
                  color: Colors.white,
                  child: new Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            height: 55.0,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Icon(AntDesign.getIconData("user"),
                                    color: Theme.Colors.loginGradientEnd),
                                new Padding(
                                    padding:
                                        EdgeInsets.only(top: 7.0, left: 10.0),
                                    child: new Text('Cuenta',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600)))
                              ],
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: new DashLine(
                              color: Colors.grey[400],
                              height: 1.0,
                            ),
                          ),
                          new GestureDetector(
                              onTap: () => showInSnackBar('Proximamente'),
                              child: new SettingsList(title: 'Editar perfil')),
                          new DashLine(
                            color: Colors.grey[400],
                            height: 1.0,
                          ),
                          new GestureDetector(
                              onTap: () => showInSnackBar('Proximamente'),
                              child: new SettingsList(
                                  title: 'Ajustes de la cuenta'))
                        ],
                      ))),
              new Container(
                  height: 20,
                  width: double.infinity,
                  color: Colors.transparent),
              new Container(
                  color: Colors.white,
                  child: new Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            height: 55.0,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Icon(AntDesign.getIconData("inbox"),
                                    color: Theme.Colors.loginGradientEnd),
                                new Padding(
                                    padding:
                                        EdgeInsets.only(top: 7.0, left: 10.0),
                                    child: new Text('Otros',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600)))
                              ],
                            ),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: new DashLine(
                              color: Colors.grey[400],
                              height: 1.0,
                            ),
                          ),
                          new SettingsList(
                              title: 'Contactanos', action: goToContact),
                          new DashLine(
                            color: Colors.grey[400],
                            height: 1.0,
                          ),
                          new SettingsList(
                            title: 'Términos y condiciones',
                            action: goConditions,
                          )
                        ],
                      ))),
              new Container(
                  height: 20,
                  width: double.infinity,
                  color: Colors.transparent),
              GestureDetector(
                  onTap: logout,
                  child: Container(
                    height: 60.0,
                    decoration: new BoxDecoration(color: Colors.white),
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(width: 13.0),
                          new Icon(
                            AntDesign.getIconData("logout"),
                            color: Colors.red,
                            size: 15.0,
                          ),
                          new Container(width: 10.0),
                          new Text('Cerrar sesión',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600)),
                        ]),
                  )),
              new Container(
                  height: 20,
                  width: double.infinity,
                  color: Colors.transparent),
            ],
          ))
        ],
      ),
    );
  }
}
