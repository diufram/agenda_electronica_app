// To parse this JSON data, do
//
//     final apoderadoTareasAlumno = apoderadoTareasAlumnoFromJson(jsonString);

import 'dart:convert';

List<ApoderadoTareasAlumno> apoderadoTareasAlumnoFromJson(String str) =>
    List<ApoderadoTareasAlumno>.from(
        json.decode(str).map((x) => ApoderadoTareasAlumno.fromJson(x)));

String apoderadoTareasAlumnoToJson(List<ApoderadoTareasAlumno> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApoderadoTareasAlumno {
  final int tareaId;
  final String titulo;
  final String descripcion;
  final String profesorNombre;
  final DateTime fechaPresentacion;
  final bool estado;

  ApoderadoTareasAlumno({
    required this.tareaId,
    required this.titulo,
    required this.descripcion,
    required this.profesorNombre,
    required this.fechaPresentacion,
    required this.estado,
  });

  factory ApoderadoTareasAlumno.fromJson(Map<String, dynamic> json) =>
      ApoderadoTareasAlumno(
        tareaId: json["tarea_id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        profesorNombre: json["profesor_nombre"],
        fechaPresentacion: DateTime.parse(json["fecha_presentacion"]),
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "tarea_id": tareaId,
        "titulo": titulo,
        "descripcion": descripcion,
        "profesor_nombre": profesorNombre,
        "fecha_presentacion":
            "${fechaPresentacion.year.toString().padLeft(4, '0')}-${fechaPresentacion.month.toString().padLeft(2, '0')}-${fechaPresentacion.day.toString().padLeft(2, '0')}",
        "estado": estado,
      };
}
