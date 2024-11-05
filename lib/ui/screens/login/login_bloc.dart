import 'dart:convert';

import 'package:agenda_electronica/domain/models/login_model.dart';
import 'package:agenda_electronica/domain/repository/auth_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/request/login_request.dart';
import 'package:flutter/material.dart';

enum LoginState {
  loading,
  initial,
}

class LoginBloc extends ChangeNotifier {
  LocalRepositoryInterface localRepositoryInterface;
  AuthRepositoryInterface authRepositoryInterface;

  LoginBloc(
      {required this.authRepositoryInterface,
      required this.localRepositoryInterface});

  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  TextEditingController namedInput = TextEditingController();
  TextEditingController phoneInput = TextEditingController();

  String error = "";

  Future<void> login() async {
    try {
      final login = LoginRequest(emailInput.text, passwordInput.text);
      final response = await authRepositoryInterface.login(login);
      if (response.statusCode == 404) {
        error = jsonDecode(response.body)['message'].toString();
        notifyListeners();
      } else if (response.statusCode == 200) {
        final res = loginFromJson(response.body);
        await localRepositoryInterface.saveToken(res.token);
        final user = res.user;
        await localRepositoryInterface.saveUser(user);
      }
    } catch (e) {}
  }
}
