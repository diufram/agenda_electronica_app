import 'package:agenda_electronica/domain/repository/alumno_repository_intr.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
}
