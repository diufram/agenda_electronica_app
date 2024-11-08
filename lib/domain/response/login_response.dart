import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final int id;
  final String nombre;
  final int tipo;

  LoginResponse({
    required this.id,
    required this.nombre,
    required this.tipo,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        nombre: json["nombre"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "tipo": tipo,
      };
}
