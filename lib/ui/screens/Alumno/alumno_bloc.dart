import 'package:agenda_electronica/domain/repository/alumno_repository_intr.dart';
import 'package:agenda_electronica/domain/response/alumno_materia_response.dart';
import 'package:agenda_electronica/domain/response/alumno_tareas_materia_response.dart';
import 'package:flutter/material.dart';

class AlumnoBloc extends ChangeNotifier {
  AlumnoRepositoryInterface alumnoRepositoryInterface;
  AlumnoBloc({required this.alumnoRepositoryInterface});

  Future<List<AlumnoMateria>> getAlumnoMaterias() async {
    final response = await alumnoRepositoryInterface.getAlumnoMaterias(2);
    return alumnoMateriaFromJson(response.body);
  }

  Future<List<AlumnoTareasMateria>> getTareasFromMateria(int idMateria) async {
    final response =
        await alumnoRepositoryInterface.getAlumnoDeberes(idMateria);
    return alumnoTareasMateriaFromJson(response.body);
  }
}
