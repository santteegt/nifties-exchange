import 'dart:async';
import 'package:tickets/model/address.dart';
import 'package:tickets/model/events.dart';
import 'package:tickets/model/ticket_user.dart';
import 'package:tickets/model/user.dart';

abstract class Service {
  Future<Map> genres();
  Future<Map> login(Map data);
  Future<Map> signup(Map data);
  Future<Map> validEmail();
  setValidEmail();
  saveFeed(Map data);
  // Get user address based on ip
  Future<Address> address();
  Future<User> getUser();
  // Get user session
  inSession();
  // Events
  Future<Events> getAllEvents();
  Future<Map> saveTicket(Map data);
  // tickets
  Future<List<UserTicket>> getAllTickets();
  // Set FCM 
  updateFCM(Map data);
  // validate ticket
  setTicket(Map data);
}
