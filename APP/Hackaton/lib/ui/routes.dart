import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tickets/presenter/presenter.dart';
import 'package:tickets/ui/login_page.dart';
import 'package:tickets/ui/principal/principal.dart';
import 'package:tickets/utils/auth/token.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Routes implements InSession {
  BuildContext context;
  final Token token = new Token();
  final routes = <String, WidgetBuilder>{
    '/Login': (BuildContext context) => new LoginPage(),
    '/Home': (BuildContext context) => new Principal()
  };

  setPage(Widget home) {
    runApp(new MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          Locale("es"),
          Locale("en")
        ],
        theme: ThemeData(
          primaryColor: Color(0xFF2f3640),
          accentColor: Color(0xFF353b48),
        ),
        routes: routes,
        home: home));
  }

  Routes() {
    token.hasToken().then((token) {
      if (token == true)
        ApiPresenter.session(this, 'checkSession', null).exec();
      else
        setPage(new LoginPage());
    });
  }

  @override
  void onError(DioError err) {
    token.deleteToken();
    setPage(new LoginPage());
  }

  @override
  void onSession() {
    setPage(new Principal());
  }
}
