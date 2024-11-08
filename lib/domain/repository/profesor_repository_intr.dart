import 'package:agenda_electronica/domain/request/tarea_request.dart';
import 'package:http/http.dart';

abstract class ProfesorRepositoryInterface {
  Future<Response> getCursosProfesor(int idProfesor);

  Future<Response> getMateriasFromCurso(int idProfesor, int idCurso);

  Future<Response> getTareasFromMateria(int idMateriaHorario);

  Future<Response> getAlumnosForMateria(int idMateriaHorario);

  Future<void> createTarea(int idMateriaHorario, TareaRequest tarea);
}
