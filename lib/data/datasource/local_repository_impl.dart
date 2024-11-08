import 'package:agenda_electronica/domain/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/local_repository_intr.dart';

const _id = "IDDELUSUARIO";
const _nombre = "NOMBRECOMPLETO";
const _tipo = "TIPODEUSUARIO";

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> saveUser(LoginResponse user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_id, user.id.toString());
    sharedPreferences.setString(_nombre, user.nombre);
    sharedPreferences.setString(_nombre, user.tipo.toString());
  }

  @override
  Future<int> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final id = sharedPreferences.getString(_id);
    return int.parse(id!);
  }
}
