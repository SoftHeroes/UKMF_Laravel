import 'package:flutter/foundation.dart';

class UserDetailsProvider with ChangeNotifier {
  String _mobileNumber = '';
  String _countryCode = '';
  String _otp = '';

  String get mobileNumber => _mobileNumber;
  String get countryCode => _countryCode;
  String get otp => _otp;

  set mobileNumber(String newValue) {
    _mobileNumber = newValue;
    notifyListeners();
  }

  set countryCode(String newValue) {
    _countryCode = newValue;
    notifyListeners();
  }

  set otp(String newValue) {
    _otp = newValue;
    notifyListeners();
  }
}
