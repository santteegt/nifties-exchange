import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tickets/style/theme.dart' as Theme;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Conditions extends StatefulWidget {
  Conditions({Key key}) : super(key: key);
  @override
  ConditionsState createState() => ConditionsState();
}

class ConditionsState extends State<Conditions> {
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
    return new WebviewScaffold(
      url: 'http://34.193.27.21:3020/conditions',
      appBar: AppBar(
        centerTitle: true,
        title: Text('Términos y Condiciones',
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
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.white12,
        child: const Center(
          child: Text('Cargando.....'),
        ),
      ),
    );
  }
}
