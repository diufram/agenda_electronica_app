// To parse this JSON data, do
//
//     final profesorAlumnosMateria = profesorAlumnosMateriaFromJson(jsonString);

import 'dart:convert';

List<ProfesorAlumnosMateria> profesorAlumnosMateriaFromJson(String str) =>
    List<ProfesorAlumnosMateria>.from(
        json.decode(str).map((x) => ProfesorAlumnosMateria.fromJson(x)));

String profesorAlumnosMateriaToJson(List<ProfesorAlumnosMateria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfesorAlumnosMateria {
  int id;
  String nombre;

  ProfesorAlumnosMateria({
    required this.id,
    required this.nombre,
  });

  factory ProfesorAlumnosMateria.fromJson(Map<String, dynamic> json) =>
      ProfesorAlumnosMateria(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
