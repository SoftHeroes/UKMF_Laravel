import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class MobileNumberVerificationScheduler with ChangeNotifier {
  bool _isGettingOTP = false;
  bool _isIAgree = false;
  String _mobileNumber = "";
  String _countryCode = "+91";
  Response _response;

  bool get isGettingOTP => _isGettingOTP;
  bool get isIAgree => _isIAgree;
  String get mobileNumber => _mobileNumber;
  String get countryCode => _countryCode;
  Response get response => _response;

  set isGettingOTP(bool newValue) {
    _isGettingOTP = newValue;
    notifyListeners();
  }

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

  set response(Response newValue) {
    _response = newValue;
    notifyListeners();
  }
}
