import 'package:flutter/material.dart';

import '../../../domain/repository/auth_repository_intr.dart';
import '../../../domain/repository/local_repository_intr.dart';

class SplashBloc extends ChangeNotifier {
  LocalRepositoryInterface localRepositoryInterface;
  AuthRepositoryInterface authRepositoryInterface;

  SplashBloc({
    required this.authRepositoryInterface,
    required this.localRepositoryInterface,
  });

  String error = "";

  Future<bool> validateSession() async {
    try {
      // await localRepositoryInterface.clearAllData();
      //final token = await localRepositoryInterface.getToken();

      return false;
    } catch (e) {
      return false;
    }
  }
}
