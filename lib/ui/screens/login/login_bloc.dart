import 'package:agenda_electronica/domain/repository/auth_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/request/login_request.dart';
import 'package:agenda_electronica/domain/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginBloc extends ChangeNotifier {
  LocalRepositoryInterface localRepositoryInterface;
  AuthRepositoryInterface authRepositoryInterface;

  LoginBloc(
      {required this.authRepositoryInterface,
      required this.localRepositoryInterface});

  TextEditingController ciController = TextEditingController();

  Future<int> login() async {
    final token = OneSignal.User.pushSubscription.id;
    final login = LoginRequest(
      ci: ciController.text,
      token: token!,
    );

    final response = await authRepositoryInterface.login(login);
    if (response.statusCode == 401) {
      return 0;
    } else if (response.statusCode == 200) {
      final login = loginResponseFromJson(response.body);
      await localRepositoryInterface.saveUser(login);
      return login.tipo;
    }
    return 0;
  }
}
