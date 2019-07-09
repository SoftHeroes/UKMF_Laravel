import 'package:flutter/foundation.dart';

class MobileNumberVerificationScheduler with ChangeNotifier {
  bool _isIAgree = false;
  String _mobileNumber = "";
  String _countryCode = "";

  bool get isIAgree => _isIAgree;
  String get mobileNumber => _mobileNumber;
  String get countryCode => _countryCode;

  set mobileNumber(String newValue) {
    _mobileNumber = newValue;
    notifyListeners();
  }

  set countryCode(String newValue) {
    _countryCode = newValue;
    notifyListeners();
  }

  set isIAgree(bool newValue) {
    _isIAgree = newValue;
    notifyListeners();
  }
}
