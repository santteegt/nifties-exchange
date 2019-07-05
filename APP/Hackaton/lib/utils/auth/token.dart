import 'dart:async';
import 'package:tickets/utils/storage/storage.dart';

class Token {
  final shared = new Storage();
  Future<Map<String, String>> buildHeaders() async {
    String token = await shared.getString('token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  deleteToken() {
    shared.deleteString('token');
  }

  Future<bool> hasToken() async {
    if (await shared.getString('token') != null) return true;
    return false;
  }

  saveToken(String value) {
    shared.saveString('token', value);
  }
}
