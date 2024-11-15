import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:agenda_electronica/domain/repository/alumno_repository_intr.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class AlumnoRepositoryImpl extends AlumnoRepositoryInterface {
  @override
  Future<Response> getAlumnoDeberes(int idMateria) async {
    try {
      var url = Uri.parse('${baseURL}alumno/tareas/$idMateria');
      final response = await http.get(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> getAlumnoMaterias(int idAlumno) async {
    try {
      var url = Uri.parse('${baseURL}alumno/materias/$idAlumno');
      final response = await http.get(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> getArchivoTarea(int idTarea) async {
    try {
      var url = Uri.parse('${baseURL}alumno/tarea/$idTarea');
      final response = await http.get(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> presentarTarea(int idTarea, int idAlumno, File archivo) async {
    try {
      var url =
          Uri.parse('${baseURL}alumno/$idAlumno/presentar/tarea/$idTarea');

      var request = http.MultipartRequest("POST", url);

      // Obtener el tipo MIME del archivo
      String mimeType =
          lookupMimeType(archivo.path) ?? 'application/octet-stream';

      // Agregar el archivo como parte de la solicitud
      request.files.add(
        await http.MultipartFile.fromPath(
          'archivo', // Nombre del campo en la solicitud, debe coincidir con el del controlador en Odoo
          archivo.path,
          contentType: MediaType.parse(mimeType),
          filename: basename(archivo.path),
        ),
      );
      // Enviar la solicitud y obtener la respuesta
      await request.send();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> generarHorario(int idAlumno) async {
    try {
      var url = Uri.parse('${baseURL}alumno/generar-horario/$idAlumno');
      final response = await http.post(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> getHorarioGenerado(int idAlumno) async {
    try {
      var url = Uri.parse('${baseURL}alumno/horario/$idAlumno');
      final response = await http.get(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> saveHorario(int idAlumno, String horario) async {
    try {
      var url = Uri.parse('${baseURL}alumno/guardar-horario/$idAlumno');
      Map data = {"horario": horario};

      await http.post(url, headers: headers, body: jsonEncode(data));
    } catch (e) {
      throw Exception(e);
    }
  }
}
