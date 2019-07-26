import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class SplashScreenScheduler with ChangeNotifier {
  bool _loadLoginPage = false;
  bool get loadLoginPage => _loadLoginPage;
  set loadLoginPage(bool newValue) {
    _loadLoginPage = newValue;
    notifyListeners();
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(bool newValue) {
    _isLogin = newValue;
    notifyListeners();
  }

  bool _isLoginCompeted = false;
  bool get isLoginCompeted => _isLoginCompeted;
  set isLoginCompeted(bool newValue) {
    _isLoginCompeted = newValue;
    notifyListeners();
  }

  bool _isAlredayUser = false;
  bool get isAlredayUser => _isAlredayUser;
  set isAlredayUser(bool newValue) {
    _isAlredayUser = newValue;
    notifyListeners();
  }

  Response _response;
  Response get response => _response;
  set response(Response newValue) {
    _response = newValue;
    notifyListeners();
  }
}
