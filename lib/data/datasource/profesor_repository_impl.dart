import 'package:agenda_electronica/domain/repository/profesor_repository_intr.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
  Future<http.Response> getTareasFromMateria(int idMateriaHorario) async {
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
  Future<http.Response> getAlumnosForMateria(int idMateriaHorario) async {
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
}
