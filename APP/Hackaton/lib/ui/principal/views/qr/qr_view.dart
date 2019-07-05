import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:tickets/presenter/presenter.dart';
import 'package:vibration/vibration.dart';
import 'package:tickets/style/theme.dart' as Theme;

class QRView extends StatefulWidget {
  final List<CameraDescription> cameras;
  QRView({Key key, this.cameras});
  @override
  _QRViewState createState() => _QRViewState();
}

class _QRViewState extends State<QRView>
    with SingleTickerProviderStateMixin
    implements APIResult {
  QRReaderController controller;
  AnimationController animationController;
  Animation<double> verticalPosition;
  String _ticketStatus = 'Esperando ticket...';

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );

    animationController.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
    verticalPosition = Tween<double>(begin: 0.0, end: 300.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear))
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          animationController.reverse();
        } else if (state == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    controller = new QRReaderController(
        widget.cameras[0], ResolutionPreset.medium, [CodeFormat.qr],
        (dynamic value) {
      ApiPresenter(this, 'setTicket', json.decode(value)).exec();
      new Future.delayed(const Duration(seconds: 5), controller.startScanning);
    });
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller.startScanning();
    });
  }

  @override
  void dispose() {
    controller?.stopScanning();
    controller?.dispose();
    super.dispose();
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'No camera selected',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return new AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: new QRReaderPreview(controller),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (!controller.value.isInitialized) {
      return new Container();
    } else
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(' Escanear Ticket',
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
        body: Stack(
          children: <Widget>[
            new Center(
              child: new Column(
                children: <Widget>[
                  new Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: new Text('Coloca el qr del ticket',
                          style: TextStyle(
                              color: Theme.Colors.loginGradientEnd,
                              fontSize: 18.0))),
                  new Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: new Text(
                          'Cuando se valide el ticket vibrará el teléfono como señal de que se completo el proceso admeàs de aparecer el hash de la transacciòn y detalles del ticket',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.black, fontSize: 14.0)))
                ],
              ),
            ),
            new Center(
              child: Stack(
                children: <Widget>[
                  new Container(
                      height: 300.0,
                      width: 300.0,
                      child: _cameraPreviewWidget()),
                  SizedBox(
                    height: 300.0,
                    width: 300.0,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0)),
                    ),
                  ),
                  Positioned(
                    top: verticalPosition.value,
                    child: Container(
                      width: 300.0,
                      height: 4.0,
                      color: Colors.teal,
                    ),
                  )
                ],
              ),
            ),
            new Positioned(
                top: height / 1.7 + 20,
                right: 10,
                left: 10,
                child: new Center(
                    child: new Column(
                  children: <Widget>[
                    new Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: new Column(
                          children: <Widget>[
                            new Text(_ticketStatus,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0))
                          ],
                        ))
                  ],
                )))
          ],
        ),
      );
  }

  @override
  void onError(DioError err) {
    setState(() {
      _ticketStatus = 'Error al validar tickets!';
    });
  }

  @override
  void onResult(value) {
    setState(() {
      _ticketStatus = 'Ticket validado!';
    });
    Vibration.vibrate(duration: 1000);
    //print(value);
  }
}
