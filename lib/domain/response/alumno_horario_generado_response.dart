// To parse this JSON data, do
//
//     final alumnoHorarioGenerado = alumnoHorarioGeneradoFromJson(jsonString);

import 'dart:convert';

AlumnoHorarioGenerado alumnoHorarioGeneradoFromJson(String str) =>
    AlumnoHorarioGenerado.fromJson(json.decode(str));

String alumnoHorarioGeneradoToJson(AlumnoHorarioGenerado data) =>
    json.encode(data.toJson());

class AlumnoHorarioGenerado {
  final List<Jueve> lunes;
  final List<Jueve> martes;
  final List<Jueve> miercoles;
  final List<Jueve> jueves;
  final List<Jueve> viernes;

  AlumnoHorarioGenerado({
    required this.lunes,
    required this.martes,
    required this.miercoles,
    required this.jueves,
    required this.viernes,
  });

  factory AlumnoHorarioGenerado.fromJson(Map<String, dynamic> json) =>
      AlumnoHorarioGenerado(
        lunes: List<Jueve>.from(json["Lunes"].map((x) => Jueve.fromJson(x))),
        martes: List<Jueve>.from(json["Martes"].map((x) => Jueve.fromJson(x))),
        miercoles:
            List<Jueve>.from(json["Miercoles"].map((x) => Jueve.fromJson(x))),
        jueves: List<Jueve>.from(json["Jueves"].map((x) => Jueve.fromJson(x))),
        viernes:
            List<Jueve>.from(json["Viernes"].map((x) => Jueve.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Lunes": List<dynamic>.from(lunes.map((x) => x.toJson())),
        "Martes": List<dynamic>.from(martes.map((x) => x.toJson())),
        "Miercoles": List<dynamic>.from(miercoles.map((x) => x.toJson())),
        "Jueves": List<dynamic>.from(jueves.map((x) => x.toJson())),
        "Viernes": List<dynamic>.from(viernes.map((x) => x.toJson())),
      };
}

class Jueve {
  final Materia materia;
  final Hora horaInicio;
  final Hora horaFin;

  Jueve({
    required this.materia,
    required this.horaInicio,
    required this.horaFin,
  });

  factory Jueve.fromJson(Map<String, dynamic> json) => Jueve(
        materia: materiaValues.map[json["Materia"]]!,
        horaInicio: horaValues.map[json["hora inicio"]]!,
        horaFin: horaValues.map[json["hora fin"]]!,
      );

  Map<String, dynamic> toJson() => {
        "Materia": materiaValues.reverse[materia],
        "hora inicio": horaValues.reverse[horaInicio],
        "hora fin": horaValues.reverse[horaFin],
      };
}

enum Hora { THE_1400, THE_1440, THE_1520, THE_1600, THE_1640 }

final horaValues = EnumValues({
  "14:00": Hora.THE_1400,
  "14:40": Hora.THE_1440,
  "15:20": Hora.THE_1520,
  "16:00": Hora.THE_1600,
  "16:40": Hora.THE_1640
});

enum Materia { CIENCIAS_NATURALES, CIENCIAS_SOCIALES, FILOSOFIA, MATEMATICAS }

final materiaValues = EnumValues({
  "Ciencias Naturales": Materia.CIENCIAS_NATURALES,
  "Ciencias Sociales": Materia.CIENCIAS_SOCIALES,
  "Filosofia": Materia.FILOSOFIA,
  "Matematicas": Materia.MATEMATICAS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
