import 'package:agenda_electronica/domain/repository/apoderado_repository_intr.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApoderadoRepositoryImpl extends ApoderadoRepositoryInterface {
  @override
  Future<Response> getAlumnosFromApoderado(int idApoderado) async {
    try {
      var url = Uri.parse('${baseURL}apoderado/$idApoderado/alumnos');
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
      var url = Uri.parse('${baseURL}apoderado/materias/$idAlumno');
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
  Future<Response> getNotificaciones(int isApoderado) async {
    try {
      var url = Uri.parse('${baseURL}apoderado/notificaciones/$isApoderado');
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
  Future<void> marcarVisto(int idTarea) async {
    try {
      var url = Uri.parse('${baseURL}apoderado/notificaciones/marcar/$idTarea');
      await http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> getTareasFromAlumno(int idAlumno) async {
    try {
      var url = Uri.parse('${baseURL}apoderado/tareas/$idAlumno');
      final response = await http.get(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
