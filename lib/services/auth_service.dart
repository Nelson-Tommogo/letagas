import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Replace with actual Firebase auth
    if (email == 'test@example.com' && password == 'password') {
      _errorMessage = null;
    } else {
      _errorMessage = 'Invalid email or password';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Replace with actual Firebase auth
    _errorMessage = null;

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
