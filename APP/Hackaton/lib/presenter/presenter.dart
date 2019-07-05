import 'package:dio/dio.dart';
import 'package:tickets/services/api.dart';

abstract class APIResult {
  void onResult(value);
  void onError(DioError err);
}

abstract class GetEvents {
  void onResultEvents(value);
  void onErrorEvents(DioError err);
}

abstract class InSession {
  void onSession();
  void onError(DioError err);
}

class ApiPresenter {
  APIResult _result;
  InSession _session;
  GetEvents _events;
  String _method;
  ApiService _service;
  Map<String, dynamic> _map;

  ApiPresenter(this._result, this._method, this._map) {
    _service = new ApiService();
  }

  ApiPresenter.session(this._session, this._method, this._map) {
    _service = new ApiService();
  }

  ApiPresenter.events(this._events, this._method, this._map) {
    _service = new ApiService();
  }

  exec() {
    switch (_method) {
      case 'getGenres':
        _getGenres();
        break;
      case 'loginUser':
        _loginUser();
        break;
      case 'registerUser':
        _registerUser();
        break;
      case 'validEmail':
        _validateEmail();
        break;
      case 'setValidEmail':
        _setValidEmail();
        break;
      case 'saveFeed':
        _saveFeed();
        break;
      case 'getAddress':
        _getCurrentAddress();
        break;
      case 'getUser':
        _getUserData();
        break;
      case 'checkSession':
        _getSessionUser();
        break;
      case 'getAllEvents':
        _getAllEvents();
        break;
      case 'saveTicket':
        _saveTicket();
        break;
      case 'getUserTicket':
        _getUserTickets();
        break;
      case 'setFCM':
        _setFCM();
        break;
      case 'setTicket':
        _validateTicket();
        break;
    }
  }

  // get feed genres
  void _getGenres() {
    assert(_result != null);
    _service
        .genres()
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // login user
  void _loginUser() {
    assert(_result != null);
    _service
        .login(_map)
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // register user
  void _registerUser() {
    assert(_result != null);
    _service
        .signup(_map)
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // validate email
  void _validateEmail() {
    assert(_result != null);
    _service
        .validEmail()
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // validate email
  void _setValidEmail() {
    assert(_result != null);
    _service
        .setValidEmail()
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // save user feed cards
  void _saveFeed() {
    assert(_result != null);
    _service
        .saveFeed(_map)
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // Get address of user based on ip
  void _getCurrentAddress() {
    assert(_result != null);
    _service
        .address()
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // Get basic user data
  void _getUserData() {
    assert(_result != null);
    _service
        .getUser()
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // Chceck session user
  void _getSessionUser() {
    assert(_session != null);
    _service
        .inSession()
        .then((response) => _session.onSession())
        .catchError((onError) => _session.onError(onError));
  }

  // get all events that show in principal page
  void _getAllEvents() {
    assert(_events != null);
    _service
        .getAllEvents()
        .then((response) => _events.onResultEvents(response))
        .catchError((onError) => _events.onErrorEvents(onError));
  }

  // Save user ticket
  void _saveTicket() {
    assert(_result != null);
    _service
        .saveTicket(_map)
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // Save user ticket
  void _getUserTickets() {
    assert(_result != null);
    _service
        .getAllTickets()
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // Save user ticket
  void _setFCM() {
    assert(_result != null);
    _service
        .updateFCM(_map)
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }

  // validate ticket
  void _validateTicket() {
    assert(_result != null);
    _service
        .setTicket(_map)
        .then((response) => _result.onResult(response))
        .catchError((onError) => _result.onError(onError));
  }
}
