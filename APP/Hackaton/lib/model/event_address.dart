class EventAddress {
  final String country;
  final String city;
  final String colony;
  final String other;
  EventAddress({this.country, this.city, this.colony, this.other});
  factory EventAddress.fromJson(Map<String, dynamic> json) =>
      _itemFromJson(json);
}

EventAddress _itemFromJson(Map<String, dynamic> json) {
  return EventAddress(
      country: json['country'] as String,
      city: json['city'] as String,
      colony: json['colony'] as String,
      other: json['other'] as String);
}
