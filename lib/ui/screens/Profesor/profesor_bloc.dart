import 'package:agenda_electronica/domain/repository/profesor_repository_intr.dart';
import 'package:agenda_electronica/domain/response/profesor_alumnos_materia_response.dart';
import 'package:agenda_electronica/domain/response/profesor_cursos_response.dart';
import 'package:agenda_electronica/domain/response/profesor_materias_curso.dart';
import 'package:agenda_electronica/domain/response/profesor_tareas_materia_response.dart';
import 'package:flutter/material.dart';

class ProfesorBloc extends ChangeNotifier {
  ProfesorRepositoryInterface profesorRepositoryInterface;
  ProfesorBloc({required this.profesorRepositoryInterface});

  Future<List<ProfesorCursos>> getCursos() async {
    final response = await profesorRepositoryInterface.getCursosProfesor(1);
    return profesorCursosFromJson(response.body);
  }

  Future<List<ProfesorMateriasCurso>> getMateriasFromCursos(int cursoId) async {
    final response =
        await profesorRepositoryInterface.getMateriasFromCurso(1, cursoId);
    return profesorMateriasCursoFromJson(response.body);
  }

  Future<List<ProfesorTareasMateria>> getTareasFromMateria(
      int idMateriaHorario) async {
    final response = await profesorRepositoryInterface
        .getTareasFromMateria(idMateriaHorario);
    return profesorTareasMateriaFromJson(response.body);
  }

  Future<List<ProfesorAlumnosMateria>> getAlumnosFromMateria(
      int idMateriaHorario) async {
    final response = await profesorRepositoryInterface
        .getAlumnosForMateria(idMateriaHorario);
    return profesorAlumnosMateriaFromJson(response.body);
  }
}
