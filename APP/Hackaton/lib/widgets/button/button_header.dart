import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tickets/style/theme.dart' as Theme;

class ButtonHeader extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final String icon;
  final bool isActive;
  ButtonHeader({this.buttonName, this.icon, this.onPressed, this.isActive});
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: new Container(
          height: 45,
          child: FlatButton.icon(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(7.0)),
            color: this.isActive ? Colors.white : Colors.black26,
            icon: new Icon(AntDesign.getIconData(icon),
                color: this.isActive
                    ? Theme.Colors.loginGradientStart
                    : Colors.white, size: 13), //`Icon` to display
            label: Text(buttonName,
                style: TextStyle(
                    color: this.isActive ? Theme.Colors.loginGradientStart : Colors.white,
                    fontWeight: FontWeight.w600, fontSize: 13)), //`Text` to display
            onPressed: this.onPressed,
          ),
        ));
  }
}
