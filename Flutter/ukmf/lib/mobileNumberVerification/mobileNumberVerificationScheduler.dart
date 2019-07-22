import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class MobileNumberVerificationScheduler with ChangeNotifier {
  bool _saving = false;
  bool _isIAgree = false;
  bool _isGetOTPCalled = false;
  String _mobileNumber = "";
  String _countryCode = "+91";
  Response _response;

  bool get saving => _saving;
  bool get isIAgree => _isIAgree;
  bool get isGetOTPCalled => _isGetOTPCalled;
  String get mobileNumber => _mobileNumber;
  String get countryCode => _countryCode;
  Response get response => _response;

  set saving(bool newValue) {
    _saving = newValue;
    notifyListeners();
  }

  set mobileNumber(String newValue) {
    _mobileNumber = newValue;
    notifyListeners();
  }

  set isGetOTPCalled(bool newValue) {
    _isGetOTPCalled = newValue;
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
