import 'package:flutter/material.dart';

import '../modeles/User.dart';
import '../services/AuthService.dart';


class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    _user = await AuthService.loginUser(email, password);
    notifyListeners();
  }

  Future<void> register(User user) async {
    _user = await AuthService.registerUser(user);
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}