import 'dart:io';

import 'package:http/http.dart';

abstract class AlumnoRepositoryInterface {
  Future<Response> getAlumnoMaterias(int idAlumno);
  Future<Response> getAlumnoDeberes(int idMateria);
  Future<Response> getArchivoTarea(int idTarea);
  Future<void> presentarTarea(int idTarea, int idAlumno, File archivo);
  Future<Response> generarHorario(int idAlumno);
  Future<void> saveHorario(int idAlumno, String horario);
  Future<Response> getHorarioGenerado(int idAlumno);
}
