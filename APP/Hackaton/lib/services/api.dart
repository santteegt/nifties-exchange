import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tickets/model/address.dart';
import 'package:tickets/model/events.dart';
import 'package:tickets/model/service.dart';
import 'package:tickets/model/ticket_user.dart';
import 'package:tickets/model/user.dart';
import 'package:tickets/utils/auth/token.dart';

class ApiService implements Service {
  Dio dio = new Dio();
  final token = new Token();
  final Map<String, String> localHeaders = {"Content-Type": "application/json"};

  ApiService() {
    dio.options.baseUrl = 'http://34.193.27.21:3020/';
    dio.options.connectTimeout = 6000;
    dio.options.receiveTimeout = 6000;
  }

  dynamic checkResponse(response) {
    return response.data;
  }

  Future<String> getIPAddressUsingFuture() async {
    Response response = await Dio().get('https://api.ipify.org?format=json');
    return response.data['ip'];
  }

  @override
  Future<Address> address() async {
    Response response = await Dio().get(
        'http://api.ipstack.com/${await getIPAddressUsingFuture()}?access_key=7174bd0dd4ee9a978503cbf1fa589f4c');
    return Address.fromJson(response.data);
  }

  @override
  Future<Map> genres() async {
    Response response = await dio.get('genres',
        options: Options(
          headers: await token.buildHeaders(),
        ));
    return checkResponse(response);
  }

  @override
  Future<Map> login(Map data) async {
    Response response = await dio.post(
      'login',
      data: jsonEncode(data),
      options: Options(
        headers: this.localHeaders,
      ),
    );
    return checkResponse(response);
  }

  @override
  Future<Map> signup(Map data) async {
    Response response = await dio.post(
      'user',
      data: jsonEncode(data),
      options: Options(
        headers: this.localHeaders,
      ),
    );
    return checkResponse(response);
  }

  // Send when verification code is ok
  @override
  setValidEmail() async {
    Response response = await dio.post('email',
        options: Options(
          headers: await token.buildHeaders(),
        ));
    return checkResponse(response);
  }

  // Send requiere validated email
  @override
  Future<Map> validEmail() async {
    Response response = await dio.get('email',
        options: Options(
          headers: await token.buildHeaders(),
        ));
    return checkResponse(response);
  }

  @override
  saveFeed(Map data) async {
    Response response = await dio.post(
      'feed',
      data: jsonEncode(data),
      options: Options(
        headers: await token.buildHeaders(),
      ),
    );
    return checkResponse(response);
  }

  // Send when verification code is ok
  @override
  Future<User> getUser() async {
    Response response = await dio.get('user',
        options: Options(
          headers: await token.buildHeaders(),
        ));
    return User.fromJson(response.data);
  }

  // check session validation
  @override
  inSession() async {
    Response response = await dio.post('session',
        options: Options(
          headers: await token.buildHeaders(),
        ));
    return checkResponse(response);
  }

  @override
  Future<Events> getAllEvents() async {
    Response response = await dio.get('events',
        options: Options(
          headers: await token.buildHeaders(),
        ));
    return Events.fromJson(response.data);
  }

  // Save user ticket
  @override
  Future<Map> saveTicket(Map data) async {
    Response response = await dio.post(
      'ticket',
      data: jsonEncode(data),
      options: Options(
        headers: await token.buildHeaders(),
      ),
    );
    return checkResponse(response);
  }

  // Get tickets from user
  @override
  Future<List<UserTicket>> getAllTickets() async {
    Response response = await dio.get('ticket',
        options: Options(
          headers: await token.buildHeaders(),
        ));
    var listTickets = response.data as List;
    return listTickets.map((i) => UserTicket.fromJson(i)).toList();
  }

  // Update fcm
  @override
  updateFCM(Map data) async {
    Response response = await dio.post(
      'fcm',
      data: jsonEncode(data),
      options: Options(
        headers: await token.buildHeaders(),
      ),
    );
    checkResponse(response);
    return;
  }

  @override
  setTicket(Map data) async {
    Response response = await dio.put(
      'ticket',
      data: jsonEncode(data),
      options: Options(
        headers: await token.buildHeaders(),
      ),
    );
    return checkResponse(response);
  }
}
