import 'package:flutter/material.dart';
import 'package:tickets/model/event_address.dart';

class UserTicket {
  final String id;
  final String event;
  final String title;
  final String organizer;
  final String hash;
  final String qr;
  final String date;
  final String time;
  final String cover;
  final int persons;
  final double price;
  final bool isFree;
  bool available = true;
  Color color = Colors.teal;
  final EventAddress address;
  final String type;
  UserTicket(
      {this.id,
      this.event,
      this.title,
      this.organizer,
      this.hash,
      this.qr,
      this.date,
      this.time,
      this.cover,
      this.persons,
      this.price,
      this.isFree,
      this.available,
      this.address,
      this.type});
  factory UserTicket.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
}

UserTicket _itemFromJson(Map<String, dynamic> json) {
  return UserTicket(
    id: json['_id'] as String,
    type: json['type'] as String,
    price: json['price'].toDouble(),
    event: json['event'] as String,
    title: json['title'] as String,
    organizer: json['organizer'] as String,
    hash: json['hash'] as String,
    qr: json['qr'] as String,
    date: json['date'] as String,
    time: json['time'] as String,
    cover: json['image_cover'] as String,
    persons: json['persons'] as int,
    available: json['available'] as bool,
    isFree: json['is_free'] as bool,
    address: EventAddress.fromJson(json['address'])
  );
}
