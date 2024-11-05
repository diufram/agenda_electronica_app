import 'package:http/http.dart';

abstract class AlumnoRepositoryInterface {
  Future<Response> getAlumnoMaterias(int idAlumno);
  Future<Response> getAlumnoDeberes(int idMateria);
}
