import 'package:tickets/model/event_address.dart';
import 'package:tickets/model/event_ticket.dart';

class Event {
  final String id;
  final String title;
  final String organizer;
  final List<String> dates;
  final EventAddress address;
  final List<double> map;
  final String cover;
  final List<String> images;
  final String simpleDescription;
  final String completeDescription;
  final String faq;
  final int limitPersons;
  final double startingPrice;
  final bool isFree;
  final bool available;
  final bool featured;
  final List<EventTicket> tickets;
  final int currentTickets;
  final String category;
  final List<String> categories;
  final String created;
  Event(
      {this.id,
      this.title,
      this.organizer,
      this.dates,
      this.address,
      this.map,
      this.cover,
      this.images,
      this.simpleDescription,
      this.completeDescription,
      this.faq,
      this.limitPersons,
      this.startingPrice,
      this.isFree,
      this.available,
      this.featured,
      this.tickets,
      this.currentTickets,
      this.category,
      this.categories,
      this.created});
  factory Event.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
}

Event _itemFromJson(Map<String, dynamic> json) {
  var list = json['tickets'] as List;
  List<EventTicket> ticketsList =
      list.map((i) => EventTicket.fromJson(i)).toList();
  return Event(
      id: json['_id'] as String,
      title: json['title'] as String,
      organizer: json['organizer'] as String,
      dates: new List<String>.from(json['dates']),
      address: EventAddress.fromJson(json['address']),
      map: new List<double>.from(json['maps']),
      cover: json['image_cover'] as String,
      images: new List<String>.from(json['images']),
      simpleDescription: json['simple_description'] as String,
      completeDescription: json['complete_description'] as String,
      faq: json['faq'] as String ?? 'No disponible',
      limitPersons: json['limit_persons'] as int,
      startingPrice: json['starting_price'].toDouble(),
      isFree: json['is_free'] as bool ?? false,
      available: json['available'] as bool ?? false,
      featured: json['featured'] as bool ?? false,
      tickets: ticketsList,
      currentTickets: json['current_tickets'] as int,
      category: json['principal_category'] as String,
      categories: new List<String>.from(json['categories']),
      created: json['createdAt'] as String);
}
