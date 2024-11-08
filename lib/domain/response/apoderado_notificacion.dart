import 'dart:convert';

List<ApoderadoNofiticacion> apoderadoNofiticacionFromJson(String str) =>
    List<ApoderadoNofiticacion>.from(
        json.decode(str).map((x) => ApoderadoNofiticacion.fromJson(x)));

String apoderadoNofiticacionToJson(List<ApoderadoNofiticacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApoderadoNofiticacion {
  final int tareaId;
  final String titulo;
  final String descripcion;
  final String alumnoNombre;
  final String materiaNombre;
  final String profesorNombre;
  final DateTime fechaPresentacion;

  ApoderadoNofiticacion({
    required this.tareaId,
    required this.titulo,
    required this.descripcion,
    required this.alumnoNombre,
    required this.materiaNombre,
    required this.profesorNombre,
    required this.fechaPresentacion,
  });

  factory ApoderadoNofiticacion.fromJson(Map<String, dynamic> json) =>
      ApoderadoNofiticacion(
        tareaId: json["tarea_id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        alumnoNombre: json["alumno_nombre"],
        materiaNombre: json["materia_nombre"],
        profesorNombre: json["profesor_nombre"],
        fechaPresentacion: DateTime.parse(json["fecha_presentacion"]),
      );

  Map<String, dynamic> toJson() => {
        "tarea_id": tareaId,
        "titulo": titulo,
        "descripcion": descripcion,
        "alumno_nombre": alumnoNombre,
        "materia_nombre": materiaNombre,
        "profesor_nombre": profesorNombre,
        "fecha_presentacion":
            "${fechaPresentacion.year.toString().padLeft(4, '0')}-${fechaPresentacion.month.toString().padLeft(2, '0')}-${fechaPresentacion.day.toString().padLeft(2, '0')}",
      };
}
