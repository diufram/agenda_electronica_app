import 'dart:convert';

List<ProfesorMateriasCurso> profesorMateriasCursoFromJson(String str) =>
    List<ProfesorMateriasCurso>.from(
        json.decode(str).map((x) => ProfesorMateriasCurso.fromJson(x)));

String profesorMateriasCursoToJson(List<ProfesorMateriasCurso> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfesorMateriasCurso {
  int id;
  String materiaNombre;
  String horario;
  int cantidadAlumnos;

  ProfesorMateriasCurso({
    required this.id,
    required this.materiaNombre,
    required this.horario,
    required this.cantidadAlumnos,
  });

  factory ProfesorMateriasCurso.fromJson(Map<String, dynamic> json) =>
      ProfesorMateriasCurso(
        id: json["id"],
        materiaNombre: json["materia_nombre"],
        horario: json["horario"],
        cantidadAlumnos: json["cantidad_alumnos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "materia_nombre": materiaNombre,
        "horario": horario,
        "cantidad_alumnos": cantidadAlumnos,
      };
}
