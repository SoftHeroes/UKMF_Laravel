import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class SignUpScheduler with ChangeNotifier {
  bool _isSigningUp = false;
  bool get isSigningUp => _isSigningUp;
  set isSigningUp(bool newValue) {
    _isSigningUp = newValue;
    notifyListeners();
  }

  String _password;
  String get password => _password;
  set password(String newValue) {
    _password = newValue;
    notifyListeners();
  }

  String _confirmPassword;
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String newValue) {
    _confirmPassword = newValue;
    notifyListeners();
  }

  String _firstName;
  String get firstName => _firstName;
  set firstName(String newValue) {
    _firstName = newValue;
    notifyListeners();
  }

  String _lastName;
  String get lastName => _lastName;
  set lastName(String newValue) {
    _lastName = newValue;
    notifyListeners();
  }

  String _emailID;
  String get emailID => _emailID;
  set emailID(String newValue) {
    _emailID = newValue;
    notifyListeners();
  }

  String _phoneNumber;
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String newValue) {
    _phoneNumber = newValue;
    notifyListeners();
  }

  String _planID = '1';
  String get planID => _planID;
  set planID(String newValue) {
    _planID = newValue;
    notifyListeners();
  }

  String _language = "";
  String get language => _language;
  set language(String newValue) {
    _language = newValue;
    notifyListeners();
  }

  Response _response;
  Response get response => _response;
  set response(Response newValue) {
    _response = newValue;
    notifyListeners();
  }
}
