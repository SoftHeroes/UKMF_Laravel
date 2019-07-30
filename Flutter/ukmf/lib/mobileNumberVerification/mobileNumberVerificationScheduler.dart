import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class MobileNumberVerificationScheduler with ChangeNotifier {
  bool _isGettingOTP = false;
  bool get isGettingOTP => _isGettingOTP;
  set isGettingOTP(bool newValue) {
    _isGettingOTP = newValue;
    notifyListeners();
  }

  bool _isGettingOTPCompleted = false;
  bool get isGettingOTPCompleted => _isGettingOTPCompleted;
  set isGettingOTPCompleted(bool newValue) {
    _isGettingOTPCompleted = newValue;
    notifyListeners();
  }

  bool _isIAgree = false;
  bool get isIAgree => _isIAgree;
  set isIAgree(bool newValue) {
    _isIAgree = newValue;
    notifyListeners();
  }

  String _customerPassword = "";
  String get customerPassword => _customerPassword;
  set customerPassword(String newValue) {
    _customerPassword = newValue;
    notifyListeners();
  }

  String _mobileNumber = "";
  String get mobileNumber => _mobileNumber;
  set mobileNumber(String newValue) {
    _mobileNumber = newValue;
    notifyListeners();
  }

  String _countryCode = "+91";
  String get countryCode => _countryCode;
  set countryCode(String newValue) {
    _countryCode = newValue;
    notifyListeners();
  }

  Response _response;
  Response get response => _response;
  set response(Response newValue) {
    _response = newValue;
    notifyListeners();
  }
}
