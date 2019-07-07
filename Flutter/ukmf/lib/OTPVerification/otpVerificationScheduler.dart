import 'package:flutter/foundation.dart';

class OTPVerificationScheduler with ChangeNotifier {
  bool _isCanResendOTP = true;
  bool _isShowingLoader = true;

  bool get isCanResendOTP => _isCanResendOTP;
  bool get isShowingLoader => _isShowingLoader;

  set isCanResendOTP(bool newValue) {
    _isCanResendOTP = newValue;
    notifyListeners();
  }

  set isShowingLoader(bool newValue) {
    _isShowingLoader = newValue;
    notifyListeners();
  }
}
