import 'package:agenda_electronica/domain/request/tarea_request.dart';
import 'package:http/http.dart';

abstract class ProfesorRepositoryInterface {
  Future<Response> getCursosProfesor(int idProfesor);

  Future<Response> getMateriasFromCurso(int idProfesor, int idCurso);

  Future<Response> getTareasFromMateria(int idMateriaHorario);

  Future<Response> getAlumnosForMateria(int idMateriaHorario);

  Future<void> createTarea(int idMateriaHorario, TareaRequest tarea);

  Future<void> createAsistencia(int idMateria, List<int> alumnos);

  Future<Response> getAsistenciasFromMateria(int idMateria);

  Future<Response> getTareasPresentadas(int idTarea);

  Future<Response> getArchivoTarea(int idTareaAlumno);

  Future<void> asignarNota(int idTareaAlumno, double nota);
}
