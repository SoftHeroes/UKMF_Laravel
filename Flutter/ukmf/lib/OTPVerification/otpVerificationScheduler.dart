import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class OTPVerificationScheduler with ChangeNotifier {
  bool _isResendingOTP = false;
  bool _isCanResendOTP = true;
  bool _isShowingLoader = true;

  String _mobileNumber = '';
  String _countryCode = '';
  String _otp = '';
  String _enterOTP = '';
  Response _response;

  bool get isResendingOTP => _isResendingOTP;
  bool get isCanResendOTP => _isCanResendOTP;
  bool get isShowingLoader => _isShowingLoader;

  String get mobileNumber => _mobileNumber;
  String get countryCode => _countryCode;
  String get otp => _otp;
  String get enterOTP => _enterOTP;
  Response get response => _response;

  set isResendingOTP(bool newValue) {
    _isResendingOTP = newValue;
    notifyListeners();
  }

  set isCanResendOTP(bool newValue) {
    _isCanResendOTP = newValue;
    notifyListeners();
  }

  set isShowingLoader(bool newValue) {
    _isShowingLoader = newValue;
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

  set otp(String newValue) {
    _otp = newValue;
    notifyListeners();
  }

  set enterOTP(String newValue) {
    _enterOTP = newValue;
    notifyListeners();
  }

  set response(Response newValue) {
    _response = newValue;
    notifyListeners();
  }
}
