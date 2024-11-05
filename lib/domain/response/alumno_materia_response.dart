import 'dart:convert';

List<AlumnoMateria> alumnoMateriaFromJson(String str) =>
    List<AlumnoMateria>.from(
        json.decode(str).map((x) => AlumnoMateria.fromJson(x)));

String alumnoMateriaToJson(List<AlumnoMateria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlumnoMateria {
  int id;
  String materiaNombre;
  String profesorNombre;

  AlumnoMateria({
    required this.id,
    required this.materiaNombre,
    required this.profesorNombre,
  });

  factory AlumnoMateria.fromJson(Map<String, dynamic> json) => AlumnoMateria(
        id: json["id"],
        materiaNombre: json["materia_nombre"],
        profesorNombre: json["profesor_nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "materia_nombre": materiaNombre,
        "profesor_nombre": profesorNombre,
      };
}
