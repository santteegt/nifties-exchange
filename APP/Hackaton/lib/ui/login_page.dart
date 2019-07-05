import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tickets/presenter/presenter.dart';
import 'package:tickets/style/theme.dart' as Theme;
import 'package:tickets/ui/principal/principal.dart';
import 'package:tickets/ui/validation/email_validation.dart';
import 'package:tickets/utils/bubble_indication_painter.dart';
import 'package:tickets/utils/storage/storage.dart';
import 'package:toast/toast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'feed/feed.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin
    implements APIResult {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;
  bool _isGoogle = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  final shared = new Storage();

  final FacebookLogin facebookSignIn = new FacebookLogin();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      _googleSignIn.disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/map.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0, bottom: 20.0),
                  child: new Image(
                      width: 230.0,
                      height: 171.0,
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          'https://github.com/santteegt/nifties-exchange/blob/master/img/conoce_mexico_Mesa%20de%20trabajo%201.png?raw=true')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      if (account != null) {
        _isGoogle = true;
        _saveSocial(
            account.displayName, account.email, account.photoUrl, account.id);
      } else
        _googleSignIn.disconnect();
    });
  }

  void _saveSocial(String name, String email, String img, String id) {
    ApiPresenter(this, 'loginUser', {
      'name': name,
      'email': email,
      'profile_img': img,
      'is_social': true,
      'id_social': id
    }).exec();
  }

  void showInSnackBar(String value) {
    Toast.show(value, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red[400],
        backgroundRadius: 10);
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em.trim());
  }

  onLogin() {
    if (loginEmailController.text.isNotEmpty &&
        loginPasswordController.text.isNotEmpty) {
      if (!isEmail(loginEmailController.text))
        showInSnackBar('Invalid email address');
      else {
        ApiPresenter(this, 'loginUser', {
          'email': loginEmailController.text.trim(),
          'password': loginPasswordController.text.trim()
        }).exec();
      }
    } else
      showInSnackBar('Please, fill all fields');
  }

  onRegister() {
    if (signupEmailController.text.isNotEmpty &&
        signupNameController.text.isNotEmpty &&
        signupPasswordController.text.isNotEmpty &&
        signupConfirmPasswordController.text.isNotEmpty) {
      if (!isEmail(signupEmailController.text))
        showInSnackBar('Correo no válido');
      else {
        if (signupPasswordController.text !=
            signupConfirmPasswordController.text)
          showInSnackBar('Las contraseñas no coinciden');
        else {
          ApiPresenter(this, 'registerUser', {
            'name': signupNameController.text,
            'email': signupEmailController.text.trim(),
            'password': signupPasswordController.text.trim()
          }).exec();
        }
      }
    } else
      showInSnackBar('Por favor, llena todos los campos');
  }

  onFacebook() {
    _login();
  }

  onGoogle() {
    _handleSignIn();
  }

  onReset() {}

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Ingresar",
                  style: TextStyle(color: left, fontSize: 15.0),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Nuevo",
                  style: TextStyle(color: right, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.mail_outline,
                              color: Color(0xFF192a56),
                              size: 22.0,
                            ),
                            hintText: "Correo electrónico",
                            hintStyle: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock_outline,
                              size: 22.0,
                              color: Color(0xFF192a56),
                            ),
                            hintText: "Contraseña",
                            hintStyle: TextStyle(fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                FontAwesome.getIconData("eye"),
                                size: 16.0,
                                color: Color(0xFF192a56),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Color(0Xff27ae60)),
                child: new Container(
                  height: 55.0,
                  width: 250.0,
                  child: new MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Theme.Colors.loginGradientEnd,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "Ingresar",
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ),
                      onPressed: onLogin),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () => onReset,
                child: Text(
                  "Olvidaste tu contraseña?",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text("ó",
                      style: TextStyle(color: Colors.black, fontSize: 14.0)),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 40.0),
                child: GestureDetector(
                  onTap: onFacebook,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesome.getIconData("facebook-f"),
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: onGoogle,
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Image.asset('assets/img/google.png',
                        width: 24, height: 24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 360.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.account_circle,
                              color: Color(0xFF192a56),
                            ),
                            hintText: "Nombre",
                            hintStyle: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmail,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.mail_outline,
                              color: Color(0xFF192a56),
                            ),
                            hintText: "Correo electrónico",
                            hintStyle: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextSignup,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock_outline,
                              color: Color(0xFF192a56),
                            ),
                            hintText: "Contraseña",
                            hintStyle: TextStyle(fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                FontAwesome.getIconData("eye"),
                                size: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextSignupConfirm,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock_outline,
                              color: Color(0xFF192a56),
                            ),
                            hintText: "Confirma tu contraseña",
                            hintStyle: TextStyle(fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignupConfirm,
                              child: Icon(
                                FontAwesome.getIconData("eye"),
                                size: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 340.0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Color(0Xff27ae60)),
                child: new Container(
                    height: 55.0,
                    width: 250.0,
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "Registrarse",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                        ),
                        onPressed: onRegister)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  @override
  void onError(DioError err) {
    if (err.type == DioErrorType.CONNECT_TIMEOUT ||
        err.type == DioErrorType.RECEIVE_TIMEOUT)
      showInSnackBar(
          'Tiempo de conexión agotado, por favor intentalo una vez más');
    else {
      showInSnackBar(err.response.data['message']);
      if (_isGoogle) {
        _googleSignIn.disconnect();
      }
    }
  }

  @override
  void onResult(value) {
    shared.saveString('token', value['access']);
    shared.saveString('email', signupEmailController.text);
    switch (value['method']) {
      case 'login':
        if (value['is_social'] != null) {
          if (value['user_status']) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Principal()),
              (Route<dynamic> route) => false,
            );
          } else
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SwipeFeedPage()));
        } else {
          if (!(value['validated'] == true)) {
            shared.saveString('email', value['email']);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => EmailValidation()));
          } else if (value['user_status']) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Principal()),
              (Route<dynamic> route) => false,
            );
          } else
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SwipeFeedPage()));
        }

        break;
      case 'register':
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => EmailValidation()));
        break;
      default:
        break;
    }
  }

  void _getData(FacebookAccessToken accessToken) async {
    final response = await Dio().get(
        'https://graph.facebook.com/v3.3/${accessToken.userId}?fields=id,name,email,picture.type(large)&access_token=${accessToken.token}');
    Map userData = json.decode(response.data);
    _saveSocial(userData['name'], userData['email'],
        userData['picture']['data']['url'], userData['id']);
  }

  void _login() async {
    final FacebookLoginResult result =
        await facebookSignIn.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _getData(result.accessToken);
        break;
      case FacebookLoginStatus.cancelledByUser:
        showInSnackBar('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        showInSnackBar('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
}
