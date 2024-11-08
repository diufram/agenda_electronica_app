import 'package:http/http.dart';

abstract class ApoderadoRepositoryInterface {
  Future<Response> getAlumnosFromApoderado(int idApoderado);
  Future<Response> getAlumnoMaterias(int idAlumno);
  Future<Response> getNotificaciones(int isApoderado);
  Future<void> marcarVisto(int idTarea);
  Future<Response> getTareasFromAlumno(int idAlumno);
}
