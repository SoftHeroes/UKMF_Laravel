import 'package:flutter/foundation.dart';

class OTPVerificationScheduler with ChangeNotifier {
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

  String _middleName;
  String get middleName => _middleName;
  set middleName(String newValue) {
    _middleName = newValue;
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

  String _planID;
  String get planID => _planID;
  set planID(String newValue) {
    _planID = newValue;
    notifyListeners();
  }

  String _language;
  String get language => _language;
  set language(String newValue) {
    _language = newValue;
    notifyListeners();
  }

  String _source;
  String get source => _source;
  set source(String newValue) {
    _source = newValue;
    notifyListeners();
  }
}
