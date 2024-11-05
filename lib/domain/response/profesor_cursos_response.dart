import 'dart:convert';

List<ProfesorCursos> profesorCursosFromJson(String str) =>
    List<ProfesorCursos>.from(
        json.decode(str).map((x) => ProfesorCursos.fromJson(x)));

String profesorCursosToJson(List<ProfesorCursos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfesorCursos {
  int cursoId;
  String cursoNombre;
  String cursoParalelo;

  ProfesorCursos({
    required this.cursoId,
    required this.cursoNombre,
    required this.cursoParalelo,
  });

  factory ProfesorCursos.fromJson(Map<String, dynamic> json) => ProfesorCursos(
        cursoId: json["curso_id"],
        cursoNombre: json["curso_nombre"],
        cursoParalelo: json["curso_paralelo"],
      );

  Map<String, dynamic> toJson() => {
        "curso_id": cursoId,
        "curso_nombre": cursoNombre,
        "curso_paralelo": cursoParalelo,
      };
}
