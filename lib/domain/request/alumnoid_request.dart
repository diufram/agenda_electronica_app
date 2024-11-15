import 'dart:convert';

AlumnoIdRequest alumnoIdRequestFromJson(String str) =>
    AlumnoIdRequest.fromJson(json.decode(str));

String alumnoIdRequestToJson(AlumnoIdRequest data) =>
    json.encode(data.toJson());

class AlumnoIdRequest {
  final List<int> alumnosId;

  AlumnoIdRequest({
    required this.alumnosId,
  });

  factory AlumnoIdRequest.fromJson(Map<String, dynamic> json) =>
      AlumnoIdRequest(
        alumnosId: List<int>.from(json["alumnos_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "alumnos_id": List<dynamic>.from(alumnosId.map((x) => x)),
      };
}
