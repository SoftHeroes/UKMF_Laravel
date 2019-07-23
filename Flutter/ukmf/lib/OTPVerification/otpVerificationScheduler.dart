import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class OTPVerificationScheduler with ChangeNotifier {
  bool _isResendingOTP = false;
  bool get isResendingOTP => _isResendingOTP;
  set isResendingOTP(bool newValue) {
    _isResendingOTP = newValue;
    notifyListeners();
  }

  bool _isCanResendOTP = true;
  bool get isCanResendOTP => _isCanResendOTP;
  set isCanResendOTP(bool newValue) {
    _isCanResendOTP = newValue;
    notifyListeners();
  }

  bool _isShowingLoader = true;
  bool get isShowingLoader => _isShowingLoader;
  set isShowingLoader(bool newValue) {
    _isShowingLoader = newValue;
    notifyListeners();
  }

  String _mobileNumber = '';
  String get mobileNumber => _mobileNumber;
  set mobileNumber(String newValue) {
    _mobileNumber = newValue;
    notifyListeners();
  }

  String _countryCode = '';
  String get countryCode => _countryCode;
  set countryCode(String newValue) {
    _countryCode = newValue;
    notifyListeners();
  }

  String _otp = '';
  String get otp => _otp;
  set otp(String newValue) {
    _otp = newValue;
    notifyListeners();
  }

  String _enterOTP = '';
  String get enterOTP => _enterOTP;
  set enterOTP(String newValue) {
    _enterOTP = newValue;
    notifyListeners();
  }

  Response _response;
  Response get response => _response;
  set response(Response newValue) {
    _response = newValue;
    notifyListeners();
  }
}
