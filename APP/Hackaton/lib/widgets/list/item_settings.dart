import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  final String title;
  final VoidCallback action;
  SettingsList(
      {this.title,
      this.action});
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: this.action,
      child: Container(
      height: 60.0,
      decoration: new BoxDecoration(color: Colors.white),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(this.title, style: TextStyle(color: Colors.grey[700], fontSize: 15.0)),
          new Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 15.0,)
        ]
      ),
    )
    );
  }
}
