import 'package:dio/dio.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tickets/model/ticket_user.dart';
import 'package:tickets/presenter/presenter.dart';
import 'package:tickets/style/theme.dart' as Theme;
import 'package:tickets/ui/principal/views/tickets/ticket_test.dart';
import 'package:tickets/utils/auth/token.dart';
import 'package:tickets/utils/notification_util.dart';
import 'package:tickets/widgets/tickets/ticket_widget.dart';

class MyTickets extends StatefulWidget {
  MyTickets({Key key}) : super(key: key);
  @override
  MyTicketsState createState() => MyTicketsState();
}

class MyTicketsState extends State<MyTickets>
    implements APIResult, NotificationReceiver {
  bool _isLoading = true;
  int _currentItem = 0;
  List<UserTicket> _tickets = new List();

  @override
  void initState() {
    super.initState();
    new NotificationUtil(service: this).init();
    ApiPresenter(this, 'getUserTicket', null).exec();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _reload() {
    setState(() {
      _tickets[_currentItem].available = false;
      _tickets[_currentItem].color = Colors.red;
    });
  }

  viewTicketsDetails(int i) {
    _currentItem = i;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TicketsDetailsT(ticket: _tickets[i], execute: _reload)));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return new Scaffold(
          body: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CircularProgressIndicator())));
    } else
      return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Mis tickets',
              style: TextStyle(fontWeight: FontWeight.w400)),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Color(0Xff27ae60), Color(0Xff87e2ad)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        body: new Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                    child: new Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: TextField(
                          cursorColor: Colors.grey[600],
                          style: TextStyle(color: Colors.grey[600]),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: 'Buscar ticket',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            prefixIcon: Icon(Icons.search,
                                color: Colors.grey[600], size: 16),
                            border: InputBorder.none,
                          ),
                        )))),
            new Expanded(
                child: new ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: _tickets.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new GestureDetector(
                        onTap: () => viewTicketsDetails(index),
                        child: new TicketWidget(
                            hash:
                                'Hash: ${_tickets[index].hash.substring(0, 20)}...',
                            title: _tickets[index].title,
                            available: _tickets[index].available,
                            date: _tickets[index].date,
                            color: _tickets[index].color,
                            place: _tickets[index].address.other),
                      );
                    }))
          ],
        ),
      );
  }

  void logout() {
    new Token().deleteToken();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
  }

  @override
  void onError(DioError err) {
    print(err.type);
    if (err.type == DioErrorType.CONNECT_TIMEOUT ||
        err.type == DioErrorType.RECEIVE_TIMEOUT)
      ApiPresenter(this, 'getUserTicket', null).exec();
    else if (err.response.statusCode == 401) logout();
  }

  @override
  void onResult(value) {
    setState(() {
      _tickets = value;
      _isLoading = false;
    });
  }

  @override
  void onNotification(Map message) {
    // TODO: implement onNotification
  }
}
