import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ButtonColor extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final String icon;
  final Color color;
  final double height;
  ButtonColor({this.buttonName, this.icon, this.onPressed, this.color, this.height = 45});
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(),
        child: new Container(
          height: this.height,
          child: FlatButton.icon(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(7.0)),
            color: this.color,
            icon: new Icon(AntDesign.getIconData(icon),
                color: Colors.white, size: 15), //`Icon` to display
            label: Text(buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600, fontSize: 13)), //`Text` to display
            onPressed: this.onPressed,
          ),
        ));
  }
}
