import 'package:flutter/foundation.dart';

class MyScheduler with ChangeNotifier {
  bool _isIAgree = false;
  bool get isIAgree => _isIAgree;

  set isIAgree(bool newValue) {
    _isIAgree = newValue;
    notifyListeners();
  }
}
