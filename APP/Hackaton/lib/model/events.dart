import 'package:tickets/model/event.dart';

class Events {
  final List<Event> featured;
  final List<Event> recent;
  final List<Event> recommended;
  Events({this.featured, this.recent, this.recommended});
  factory Events.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
}

Events _itemFromJson(Map<String, dynamic> json) {
  var featuredTemp = json['featured'] as List;
  var recentTemp = json['recent'] as List;
  var recommendedTemp = json['recent'] as List;
  List<Event> featuredList =
      featuredTemp.map((i) => Event.fromJson(i)).toList();
  List<Event> recentList = recentTemp != null ?  recentTemp.map((i) => Event.fromJson(i)).toList(): null;
  List<Event> recommendedList = recentTemp != null ?  recommendedTemp.map((i) => Event.fromJson(i)).toList(): null;
  return Events(featured: featuredList, recent: recentList, recommended: recommendedList);
}
