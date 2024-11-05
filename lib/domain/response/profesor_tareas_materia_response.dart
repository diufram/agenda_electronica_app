// To parse this JSON data, do
//
//     final profesorTareasMateria = profesorTareasMateriaFromJson(jsonString);

import 'dart:convert';

List<ProfesorTareasMateria> profesorTareasMateriaFromJson(String str) =>
    List<ProfesorTareasMateria>.from(
        json.decode(str).map((x) => ProfesorTareasMateria.fromJson(x)));

String profesorTareasMateriaToJson(List<ProfesorTareasMateria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfesorTareasMateria {
  int id;
  String titulo;
  String descripcion;
  DateTime fechaPresentacion;
  int cantidadPresentados;

  ProfesorTareasMateria({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaPresentacion,
    required this.cantidadPresentados,
  });

  factory ProfesorTareasMateria.fromJson(Map<String, dynamic> json) =>
      ProfesorTareasMateria(
        id: json["id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        fechaPresentacion: DateTime.parse(json["fecha_presentacion"]),
        cantidadPresentados: json["cantidad_presentados"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "fecha_presentacion":
            "${fechaPresentacion.year.toString().padLeft(4, '0')}-${fechaPresentacion.month.toString().padLeft(2, '0')}-${fechaPresentacion.day.toString().padLeft(2, '0')}",
        "cantidad_presentados": cantidadPresentados,
      };
}
