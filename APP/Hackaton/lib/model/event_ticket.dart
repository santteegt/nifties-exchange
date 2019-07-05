class EventTicket {
  final String id;
  final String type;
  final double price;
  final List<String> day;
  final String information;
  final bool available;
  final String startDate;
  final String expiration;
  EventTicket(
      {this.id,
      this.type,
      this.price,
      this.day,
      this.information,
      this.available,
      this.startDate,
      this.expiration});
  factory EventTicket.fromJson(Map<String, dynamic> json) =>
      _itemFromJson(json);
}

EventTicket _itemFromJson(Map<String, dynamic> json) {
  return EventTicket(
      id: json['_id'] as String,
      type: json['type_ticket'] as String,
      price: json['price'].toDouble(),
      day: new List<String>.from(json['day']),
      information: json['information'] as String,
      available: json['available'] as bool,
      startDate: json['start_date'] as String,
      expiration: json['ticket_date'] as String);
}
