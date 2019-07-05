import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tickets/model/ticket_user.dart';
import 'package:tickets/utils/notification_util.dart';

class TicketsDetails extends StatefulWidget {
  final UserTicket ticket;
  final Function execute;
  TicketsDetails({Key key, this.ticket, this.execute}) : super(key: key);
  @override
  TicketsDetailsTState createState() => TicketsDetailsTState();
}

class TicketsDetailsTState extends State<TicketsDetails>
    with TickerProviderStateMixin, NotificationReceiver {
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
        appBar: new AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: new Image.asset(
              'assets/img/title.png',
              height: 40,
            )),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 70.0),
                    child: new Center(
                      child: new Image.network(
                          'https://raw.githubusercontent.com/santteegt/nifties-exchange/master/resource/estampillas-02.png'),
                    ),
                  )
                ],
              ), 
              new Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: new Text('Hash'),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: new Text('0x0439NFDIUNIN098U89YBUGG67FGUVG6545DC'),
              )
            ],
          ),
        ));
  }

  @override
  void onNotification(Map message) {}
}
