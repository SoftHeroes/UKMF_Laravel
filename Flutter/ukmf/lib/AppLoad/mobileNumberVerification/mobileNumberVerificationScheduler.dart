import 'package:flutter/foundation.dart';

class MobileNumberVerificationScheduler with ChangeNotifier {
  bool _isIAgree = false;
  String _mobileNumber = "";

  bool get isIAgree => _isIAgree;
  String get mobileNumber => _mobileNumber;

  set mobileNumber(String newValue) {
    _mobileNumber = newValue;
    notifyListeners();
  }

  set isIAgree(bool newValue) {
    _isIAgree = newValue;
    notifyListeners();
  }
}
