import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tickets/model/address.dart';
import 'package:tickets/model/events.dart';
import 'package:tickets/model/user.dart';
import 'package:tickets/presenter/presenter.dart';
import 'package:tickets/ui/principal/views/home.dart';
import 'package:tickets/ui/principal/views/profile.dart';
import 'package:tickets/ui/principal/views/search.dart';
import 'package:tickets/ui/principal/views/tickets.dart';
import 'package:tickets/utils/auth/token.dart';
import 'package:tickets/utils/notification_util.dart';
import 'package:tickets/utils/storage/storage.dart';
import 'package:morpheus/morpheus.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Principal extends StatefulWidget {
  Principal({Key key}) : super(key: key);
  @override
  PrincipalState createState() => PrincipalState();
}

class PrincipalState extends State<Principal>
    implements APIResult, GetEvents, FCMToken {
  int currentIndex = 0;
  int notificationsCounter = 3;
  bool isLoading = true;
  Storage shared = new Storage();
  static Map user;
  List<Widget> children;
  static List<dynamic> notifications;

  Events _events;

  // Data
  Address _currentAddress;
  User _currentUser;

  @override
  void initState() {
    super.initState();
    new NotificationUtil.onToken(fcmToken: this).getToken();
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return new Scaffold(
          body: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CircularProgressIndicator())));
    } else
      return Scaffold(
          body: MorpheusTabView(child: children[currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            fixedColor: Color(0Xff27ae60),
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: new Icon(AntDesign.getIconData("home")),
                  title: new Text('Inicio')),
              BottomNavigationBarItem(
                  icon: new Icon(AntDesign.getIconData("shoppingcart")),
                  title: new Text('Marketplace')),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.confirmation_number),
                  title: new Text('Estampas')),
              BottomNavigationBarItem(
                  icon: new Icon(AntDesign.getIconData("user")),
                  title: new Text('Perfil')),
            ],
          ));
  }

  void logout() {
    new Token().deleteToken();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
  }

  @override
  void onError(DioError err) {
    if (err.type == DioErrorType.CONNECT_TIMEOUT ||
        err.type == DioErrorType.RECEIVE_TIMEOUT)
      ApiPresenter(this, 'getAddress', null).exec();
    else if (err.response.statusCode == 401)
      logout();
    else
      print(err);
  }

  void _onComplete() async {
    children = [
      HomeProfile(
          user: _currentUser, address: _currentAddress, events: _events),
      Search(),
      MyTickets(),
      Profile(user: _currentUser, address: _currentAddress)
    ];

    setState(() {
      isLoading = false;
    });
  }

  @override
  void onResult(value) {
    switch (value.runtimeType) {
      case Address:
        _currentAddress = value;
        ApiPresenter(this, 'getUser', null).exec();
        break;
      case User:
        _currentUser = value;
        ApiPresenter.events(this, 'getAllEvents', null).exec();
        break;
      default:
        break;
    }
  }

  @override
  void onErrorEvents(DioError err) {
    // TODO: implement onErrorEvents
  }

  @override
  void onResultEvents(value) {
    _events = value;
    _onComplete();
  }

  @override
  void onToken(String token) {
    ApiPresenter(this, 'setFCM', {'fcm': token}).exec();
    ApiPresenter(this, 'getAddress', null).exec();
  }
}
