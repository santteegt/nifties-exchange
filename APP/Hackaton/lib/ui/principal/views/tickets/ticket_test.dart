import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tickets/model/ticket_user.dart';
import 'package:tickets/style/theme.dart' as Theme;
import 'package:tickets/ui/feed/feed.dart';
import 'package:tickets/utils/notification_util.dart';
import 'package:tickets/widgets/separators/dash_line.dart';

class TicketsDetailsT extends StatefulWidget {
  final UserTicket ticket;
  final Function execute;
  TicketsDetailsT({Key key, this.ticket, this.execute}) : super(key: key);
  @override
  TicketsDetailsTState createState() => TicketsDetailsTState();
}

class TicketsDetailsTState extends State<TicketsDetailsT>
    with TickerProviderStateMixin, NotificationReceiver {
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;

  String _message;
  Color _color;

  @override
  void initState() {
    super.initState();
    new NotificationUtil(service: this).init();
    _message = widget.ticket.available ? 'Disponible': 'Usado';
    _color = widget.ticket.available ? widget.ticket.color : Colors.red;
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _frontScale = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  next() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SwipeFeedPage()));
  }

  String _getSmallMont() {
    String mesString;
    String month = widget.ticket.date.split("de ")[1].split(",")[0];
    switch (month) {
      case 'enero':
        mesString = "ENE";
        break;
      case 'febrero':
        mesString = "FEB";
        break;
      case 'marzo':
        mesString = "MAR";
        break;
      case 'abril':
        mesString = "ABR";
        break;
      case 'mayo':
        mesString = "MAY";
        break;
      case 'junio':
        mesString = "JUN";
        break;
      case 'julio':
        mesString = "JUL";
        break;
      case 'agosto':
        mesString = "AG";
        break;
      case 'septiembre':
        mesString = "SEP";
        break;
      case 'octubre':
        mesString = "OCT";
        break;
      case 'noviembre':
        mesString = "NOV";
        break;
      case 'diciembre':
        mesString = "DIC";
        break;
      default:
        mesString = "Invalid month";
        break;
    }
    return mesString;
  }

  resend() {}

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton(
              icon: new Icon(Icons.more_vert),
              itemBuilder: (context) {
                return <PopupMenuItem>[
                  new PopupMenuItem(child: Text('Enviar')),
                  new PopupMenuItem(child: Text('Compartir')),
                  new PopupMenuItem(child: Text('Guardar'))
                ];
              },
            ),
          ],
          centerTitle: true,
          title: Text('Detalles del ticket',
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
        body: SingleChildScrollView(
            child: new Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: new Stack(
                        children: <Widget>[
                          new Positioned(
                            child: new Align(
                                alignment: Alignment.center,
                                child: new Column(
                                  children: <Widget>[
                                    new Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: new Container(
                                          width: double.infinity,
                                          height: height / 4,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  widget.ticket.cover),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )),
                                    new Card(
                                        child: new Stack(
                                      children: <Widget>[
                                        new GestureDetector(
                                            onTap: () => {
                                                  setState(() {
                                                    if (_controller
                                                            .isCompleted ||
                                                        _controller.velocity >
                                                            0)
                                                      _controller.reverse();
                                                    else
                                                      _controller.forward();
                                                  })
                                                },
                                            child: new AnimatedBuilder(
                                              child: new Center(
                                                  child: new Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20,
                                                          left: 20,
                                                          right: 20),
                                                      child: new Column(
                                                        children: <Widget>[
                                                          new Text(
                                                              'Esta código qr contine tu entrada, enseñalo al recepcionista para validarlo',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          new Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20.0,
                                                                    bottom:
                                                                        10.0),
                                                            child: new DashLine(
                                                              color: Colors
                                                                  .grey[400],
                                                              height: 1.0,
                                                            ),
                                                          ),
                                                          Image.network(
                                                              widget.ticket.qr,
                                                              width: 225,
                                                              height: 225),
                                                          new Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10.0,
                                                                      left:
                                                                          5.0),
                                                              child: new Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      'Hash',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey[600])),
                                                                  new Text(
                                                                      widget
                                                                          .ticket
                                                                          .hash,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              13))
                                                                ],
                                                              ))
                                                        ],
                                                      ))),
                                              animation: _backScale,
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                final Matrix4 transform =
                                                    new Matrix4.identity()
                                                      ..scale(
                                                          1.0,
                                                          _backScale.value,
                                                          1.0);
                                                return new Transform(
                                                  transform: transform,
                                                  alignment:
                                                      FractionalOffset.center,
                                                  child: child,
                                                );
                                              },
                                            )),
                                        new GestureDetector(
                                            onTap: () => {
                                                  setState(() {
                                                    if (_controller
                                                            .isCompleted ||
                                                        _controller.velocity >
                                                            0)
                                                      _controller.reverse();
                                                    else
                                                      _controller.forward();
                                                  })
                                                },
                                            child: new AnimatedBuilder(
                                              animation: _frontScale,
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                final Matrix4 transform =
                                                    new Matrix4.identity()
                                                      ..scale(
                                                          1.0,
                                                          _frontScale.value,
                                                          1.0);
                                                return new Transform(
                                                  transform: transform,
                                                  alignment:
                                                      FractionalOffset.center,
                                                  child: child,
                                                );
                                              },
                                              child: new Container(
                                                  width: double.infinity,
                                                  color: Colors.white,
                                                  child: new Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 14.0,
                                                          right: 19.0,
                                                          bottom: 15.0),
                                                      child: new Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          new Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              new Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10.0),
                                                                child:
                                                                    new Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    new Text(
                                                                        widget
                                                                            .ticket
                                                                            .title,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                    new Text(
                                                                        'Por ${widget.ticket.organizer}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400))
                                                                  ],
                                                                ),
                                                              ),
                                                              new Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: 10.0,
                                                                      left:
                                                                          10.0),
                                                                  child:
                                                                      new Column(
                                                                    children: <
                                                                        Widget>[
                                                                      new Text(
                                                                          _getSmallMont(),
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w600)),
                                                                      new Text(
                                                                          widget.ticket.date.split(" ")[
                                                                              0],
                                                                          style: TextStyle(
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Theme.Colors.loginGradientEnd)),
                                                                    ],
                                                                  ))
                                                            ],
                                                          ),
                                                          new Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10.0),
                                                            child: new DashLine(
                                                              color: Colors
                                                                  .grey[400],
                                                              height: 1.0,
                                                            ),
                                                          ),
                                                          new Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10.0,
                                                                      left:
                                                                          5.0),
                                                              child: new Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      'Fecha',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey[600])),
                                                                  new Text(
                                                                      widget
                                                                          .ticket
                                                                          .date,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14)),
                                                                  new Text(
                                                                      widget
                                                                          .ticket
                                                                          .time,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14))
                                                                ],
                                                              )),
                                                          new Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10.0,
                                                                      left:
                                                                          5.0),
                                                              child: new Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      'Lugar',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey[600])),
                                                                  new Text(
                                                                      widget
                                                                          .ticket
                                                                          .address
                                                                          .other,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14)),
                                                                  new Text(
                                                                      '${widget.ticket.address.city}, ${widget.ticket.address.colony}',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14)),
                                                                  new Text(
                                                                      widget
                                                                          .ticket
                                                                          .address
                                                                          .country,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14)),
                                                                ],
                                                              )),
                                                          new Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10.0,
                                                                      left:
                                                                          5.0),
                                                              child: new Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      'Hash',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey[600])),
                                                                  new Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      new Text(
                                                                          '${widget.ticket.hash.substring(0, 14)}...',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 14)),
                                                                      new FlatButton(
                                                                        onPressed:
                                                                            () =>
                                                                                {},
                                                                        child: new Text(
                                                                            'Ver en explorer',
                                                                            style:
                                                                                TextStyle(color: Theme.Colors.loginGradientEnd, decoration: TextDecoration.underline)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )),
                                                          new Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 0.0,
                                                                      left:
                                                                          5.0),
                                                              child: new Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      'Estado del ticket',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey[600])),
                                                                  new Text(
                                                                      _message,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                              color: _color,
                                                                          fontSize:
                                                                              14)),
                                                                ],
                                                              )),
                                                          new Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 10.0,
                                                                      left:
                                                                          5.0),
                                                              child: new Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  new Text(
                                                                      'Detalles',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey[600])),
                                                                  new Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      new Text(
                                                                          '${widget.ticket.type}',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 14)),
                                                                      new Text(
                                                                          '${widget.ticket.persons} Personas',
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 14))
                                                                    ],
                                                                  ),
                                                                ],
                                                              )),
                                                          new Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10.0),
                                                            child: new Center(
                                                                child: new Text(
                                                                    'Toca para ver el reverso',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Theme
                                                                            .Colors
                                                                            .loginGradientEnd,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            14))),
                                                          )
                                                        ],
                                                      ))),
                                            ))
                                      ],
                                    )),
                                  ],
                                )),
                          ),
                          new Positioned(
                            top: height / 4.25,
                            child: new Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: new Container(
                                decoration: new BoxDecoration(
                                    color: Color(0xFFFAFAFA),
                                    borderRadius: new BorderRadius.only(
                                        topRight: const Radius.circular(40.0),
                                        bottomRight:
                                            const Radius.circular(40.0))),
                                width: 20,
                                height: 30,
                              ),
                            ),
                          ),
                          new Positioned(
                              top: height / 4.25,
                              left: width - 87,
                              child: new Align(
                                  alignment: Alignment.topRight,
                                  child: new Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Color(0xFFFAFAFA),
                                          borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(40.0),
                                              bottomLeft:
                                                  const Radius.circular(40.0))),
                                      width: 20,
                                      height: 30,
                                    ),
                                  )))
                        ],
                      ),
                    ),
                    new Container(height: 12.0),
                    new Center(
                        child: new Text('ID Pedido: #34DE455',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600))),
                    new Container(height: 3.0),
                    new Center(
                      child: new Text('Powered by Katun Tech',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Theme.Colors.loginGradientEnd)),
                    ),
                    new Container(height: 10.0),
                  ],
                ))));
  }

  @override
  void onNotification(Map message) {
    widget.execute();
    setState(() {
      _message = 'Usado';
      _color = Colors.red;
    });
  }
}
