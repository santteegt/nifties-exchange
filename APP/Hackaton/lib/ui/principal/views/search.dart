import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tickets/widgets/button/button_header.dart';
import 'package:tickets/widgets/cards/search_item.dart';

import 'details/ticket_details.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  goDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TicketsDetails()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
              height: 135,
              width: double.infinity,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                gradient: new LinearGradient(
                    colors: [Color(0Xff27ae60), Color(0Xff87e2ad)],
                    begin: const FractionalOffset(0.2, 0.2),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: new Padding(
                padding: EdgeInsets.only(top: 35),
                child: new Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.black26,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(5.0))),
                            width: width / 1.7,
                            height: 45,
                            child: TextField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintText: 'Palabras clave',
                                fillColor: Colors.white12,
                                hintStyle:
                                    TextStyle(color: Color(0xFF80FFFFFF)),
                                prefixIcon: Icon(Icons.search,
                                    color: Colors.white, size: 16),
                                border: InputBorder.none,
                              ),
                            ))),
                    new ButtonHeader(
                      buttonName: 'Ubicación',
                      icon: "pushpino",
                      isActive: false,
                      onPressed: () => {},
                    ),
                  ],
                ),
              )),
          new Container(
            width: double.infinity,
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: new Text('Precio actual de una estampa',
                      style: TextStyle(color: Colors.grey[600])),
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
                  child: new Text('\$10 Nifties',
                      style:
                          TextStyle(color: Colors.grey[800], fontSize: 28.0)),
                )
              ],
            ),
          ),
          new Expanded(
            child: new ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                new GestureDetector(
                    onTap: () => goDetails(),
                    child: new TicketItemMarket(
                      image:
                          'https://raw.githubusercontent.com/santteegt/nifties-exchange/master/resource/estampillas-02.png',
                      title: 'Zócalo',
                      description: 'Descripción del boleto',
                      place: 'Ubicaciòn: CDMX',
                      hash: '0x23234meiofnewuonf23oi',
                      block: '0x23234meiofnewuonf23oi',
                    )),
                new GestureDetector(
                    onTap: () => goDetails(),
                    child: new TicketItemMarket(
                      image:
                          'https://raw.githubusercontent.com/santteegt/nifties-exchange/master/resource/estampillas-02.png',
                      title: 'Zócalo',
                      description: 'Descripción del boleto',
                      place: 'Ubicaciòn: CDMX',
                      hash: '0x23234meiofnewuonf23oi',
                      block: '0x23234meiofnewuonf23oi',
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
