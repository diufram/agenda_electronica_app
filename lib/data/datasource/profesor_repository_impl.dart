import 'dart:convert';
import 'package:path/path.dart';
import 'package:agenda_electronica/domain/repository/profesor_repository_intr.dart';
import 'package:agenda_electronica/domain/request/tarea_request.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProfesorRepositoryImpl extends ProfesorRepositoryInterface {
  @override
  Future<Response> getCursosProfesor(int idProfesor) async {
    try {
      var url = Uri.parse('${baseURL}profesor/cursos/$idProfesor');
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
  Future<Response> getMateriasFromCurso(int idProfesor, int idCurso) async {
    try {
      var url =
          Uri.parse('${baseURL}profesor/$idProfesor/cursos/$idCurso/materias');
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
  Future<Response> getTareasFromMateria(int idMateriaHorario) async {
    try {
      var url = Uri.parse('${baseURL}profesor/tareas/$idMateriaHorario');
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
  Future<Response> getAlumnosForMateria(int idMateriaHorario) async {
    try {
      var url = Uri.parse('${baseURL}profesor/asistencia/$idMateriaHorario');
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
  Future<void> createTarea(int idMateriaHorario, TareaRequest tarea) async {
    try {
      var url = Uri.parse('${baseURL}profesor/crear/tarea/$idMateriaHorario');

      var request = http.MultipartRequest("POST", url);

      // Agregar los datos JSON como un campo form-data
      request.fields['data'] = jsonEncode({
        'titulo': tarea.titulo,
        'descripcion': tarea.descripcion,
        'fecha_presentacion': tarea.fechaPesentacion,
      });

      // Obtener el tipo MIME del archivo
      String mimeType =
          lookupMimeType(tarea.archivo.path) ?? 'application/octet-stream';

      // Agregar el archivo como parte de la solicitud
      request.files.add(
        await http.MultipartFile.fromPath(
          'archivo', // Nombre del campo en la solicitud, debe coincidir con el del controlador en Odoo
          tarea.archivo.path,
          contentType: MediaType.parse(mimeType),
          filename: basename(tarea.archivo.path),
        ),
      );
      // Enviar la solicitud y obtener la respuesta
      await request.send();
    } catch (e) {
      throw Exception(e);
    }
  }
}
