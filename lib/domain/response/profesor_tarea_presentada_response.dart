import 'dart:convert';

List<ProfesorTareaPresentada> profesorTareaPresentadaFromJson(String str) =>
    List<ProfesorTareaPresentada>.from(
        json.decode(str).map((x) => ProfesorTareaPresentada.fromJson(x)));

String profesorTareaPresentadaToJson(List<ProfesorTareaPresentada> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfesorTareaPresentada {
  final int tareaAlumnoId;
  final String alumnoNombre;
  final String archivoNombre;
  final double nota;

  ProfesorTareaPresentada({
    required this.tareaAlumnoId,
    required this.alumnoNombre,
    required this.archivoNombre,
    required this.nota,
  });

  factory ProfesorTareaPresentada.fromJson(Map<String, dynamic> json) =>
      ProfesorTareaPresentada(
        tareaAlumnoId: json["tarea_alumno_id"],
        alumnoNombre: json["alumno_nombre"],
        archivoNombre: json["archivo_nombre"],
        nota: json["nota"],
      );

  Map<String, dynamic> toJson() => {
        "tarea_alumno_id": tareaAlumnoId,
        "alumno_nombre": alumnoNombre,
        "archivo_nombre": archivoNombre,
        "nota": nota,
      };
}
