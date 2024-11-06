import 'dart:convert';

List<AlumnoTareasMateria> alumnoTareasMateriaFromJson(String str) =>
    List<AlumnoTareasMateria>.from(
        json.decode(str).map((x) => AlumnoTareasMateria.fromJson(x)));

String alumnoTareasMateriaToJson(List<AlumnoTareasMateria> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlumnoTareasMateria {
  int id;
  String titulo;
  String descripcion;
  DateTime fechaPresentacion;

  AlumnoTareasMateria({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaPresentacion,
  });

  factory AlumnoTareasMateria.fromJson(Map<String, dynamic> json) =>
      AlumnoTareasMateria(
        id: json["id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        fechaPresentacion: DateTime.parse(json["fecha_presentacion"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "fecha_presentacion":
            "${fechaPresentacion.year.toString().padLeft(4, '0')}-${fechaPresentacion.month.toString().padLeft(2, '0')}-${fechaPresentacion.day.toString().padLeft(2, '0')}",
      };
}
