class Address {
  final String countryCode;
  final String countryName;
  final String regionCode;
  final String regionName;
  final String city;
  final String zip;
  final method = 'address';
  Address(
      {this.countryCode,
      this.countryName,
      this.regionCode,
      this.regionName,
      this.city,
      this.zip});
  factory Address.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
}

Address _itemFromJson(Map<String, dynamic> json) {
  return Address(
      countryCode: json['country_code'] as String,
      countryName: json['country_name'] as String,
      regionCode: json['region_code'] as String,
      regionName: json['region_name'] as String,
      city: json['city'] as String,
      zip: json['zip'] as String);
}
