import 'dart:convert';

List<ApoderadoAlumnos> apoderadoAlumnosFromJson(String str) =>
    List<ApoderadoAlumnos>.from(
        json.decode(str).map((x) => ApoderadoAlumnos.fromJson(x)));

String apoderadoAlumnosToJson(List<ApoderadoAlumnos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApoderadoAlumnos {
  final int alumnoId;
  final String alumnoNombre;
  final String cursoNombre;

  ApoderadoAlumnos({
    required this.alumnoId,
    required this.alumnoNombre,
    required this.cursoNombre,
  });

  factory ApoderadoAlumnos.fromJson(Map<String, dynamic> json) =>
      ApoderadoAlumnos(
        alumnoId: json["alumno_id"],
        alumnoNombre: json["alumno_nombre"],
        cursoNombre: json["curso_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "alumno_id": alumnoId,
        "alumno_nombre": alumnoNombre,
        "curso_nombre": cursoNombre,
      };
}
