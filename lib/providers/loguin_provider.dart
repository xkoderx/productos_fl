import 'package:flutter/material.dart';

class LoguinProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool esValido() {
    return formKey.currentState?.validate() ?? false;
  }
}
