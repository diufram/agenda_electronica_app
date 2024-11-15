import 'dart:convert';

List<AlumnoAsistencia> alumnoAsistenciaFromJson(String str) =>
    List<AlumnoAsistencia>.from(
        json.decode(str).map((x) => AlumnoAsistencia.fromJson(x)));

String alumnoAsistenciaToJson(List<AlumnoAsistencia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlumnoAsistencia {
  final int asistenciaId;
  final DateTime fecha;
  final int cantAlumnosPresentes;

  AlumnoAsistencia({
    required this.asistenciaId,
    required this.fecha,
    required this.cantAlumnosPresentes,
  });

  factory AlumnoAsistencia.fromJson(Map<String, dynamic> json) =>
      AlumnoAsistencia(
        asistenciaId: json["asistencia_id"],
        fecha: DateTime.parse(json["fecha"]),
        cantAlumnosPresentes: json["cant_alumnos_presentes"],
      );

  Map<String, dynamic> toJson() => {
        "asistencia_id": asistenciaId,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "cant_alumnos_presentes": cantAlumnosPresentes,
      };
}
