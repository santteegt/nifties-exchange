import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tickets/model/address.dart';
import 'package:tickets/model/events.dart';
import 'package:tickets/model/user.dart';
import 'package:location/location.dart';

class HomeProfile extends StatefulWidget {
  final Address address;
  final User user;
  final Events events;
  HomeProfile({Key key, this.user, this.address, this.events})
      : super(key: key);
  @override
  HomeProfileState createState() => HomeProfileState();
}

class HomeProfileState extends State<HomeProfile>
    with TickerProviderStateMixin {
  LocationData _startLocation;
  LocationData _currentLocation;

  bool _isShow = false;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );

  CameraPosition _currentCameraPosition;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  GoogleMap googleMap;

  List<Map> data = [
    {
      'coordintes': [19.426988, -99.168245],
      'title': 'Àngel de la independencia'
    },
    {
      'coordintes': [19.432619, -99.133590],
      'title': 'Zócalo'
    },
    {
      'coordintes': [19.432485, -99.131181],
      'title': 'Palacio Nacional'
    },
    {
      'coordintes': [19.434396, -99.133085],
      'title': 'Catedral Metropolitana'
    },
    {
      'coordintes': [19.436256, -99.139465],
      'title': 'Museo Nacional de Arte'
    },
    {
      'coordintes': [19.440655, -99.139536],
      'title': 'Garibaldi'
    },
    {
      'coordintes': [19.433837, -99.140593],
      'title': 'Torre Latinoamericana'
    },
    {
      'coordintes': [19.435495, -99.141312],
      'title': 'Bellas Artes'
    },
    {
      'coordintes': [19.396266, -99.174660],
      'title': 'Crowne Plaza'
    }
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();

    for (var i = 0; i < data.length; i++) {
      _add(new LatLng(data[i]['coordintes'][0], data[i]['coordintes'][1]),
          data[i]['title'], i);
    }
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: Text(
                'Hemos detectado que te encuntras cerca de ${data[data.length - 1]}'),
            padding: EdgeInsets.all(40.0),
          );
        });
  }

  void viewDetails(String title) {
    _showModalSheet();
  }

  void _add(LatLng data, String title, int position) async {
    final MarkerId markerId = MarkerId('$position');
    final Marker marker = Marker(
      onTap: () => viewDetails(title),
      markerId: markerId,
      position: data,
      infoWindow: InfoWindow(title: title, snippet: 'Encuentra el código'),
    );
    setState(() {
      _markers[markerId] = marker;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude), zoom: 16);

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_currentCameraPosition));
            if (_isShow == false) {
              _isShow = true;
              _showModalSheet();
            }

            if (mounted) {
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;

    googleMap = GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: _initialCamera,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers.values));

    widgets = [
      Center(
        child: new Stack(
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: googleMap)
          ],
        ),
      ),
    ];

    return new MaterialApp(
        home: new Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            new Center(
                child: new Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: new Container(
                  width: 45,
                  height: 45,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(widget.user.profileImg),
                    backgroundColor: Colors.transparent,
                  )),
            ))
          ],
          title: new Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: new Image.asset('assets/img/title.png',
                  height: 45, width: 110)),
        ),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
