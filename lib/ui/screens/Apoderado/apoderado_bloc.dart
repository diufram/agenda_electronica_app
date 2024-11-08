import 'package:agenda_electronica/domain/repository/apoderado_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/response/alumno_materia_response.dart';
import 'package:agenda_electronica/domain/response/apoderado_alumnos_response.dart';
import 'package:agenda_electronica/domain/response/apoderado_notificacion.dart';
import 'package:agenda_electronica/domain/response/apoderado_tarea_alumno_response.dart';
import 'package:flutter/material.dart';

class ApoderadoBloc extends ChangeNotifier {
  ApoderadoRepositoryInterface apoderadoRepositoryInterface;
  LocalRepositoryInterface localRepositoryInterface;
  ApoderadoBloc(
      {required this.apoderadoRepositoryInterface,
      required this.localRepositoryInterface});

  Future<List<ApoderadoAlumnos>> getAlumnosFromApoderado() async {
    final id = await localRepositoryInterface.getUser();
    final response =
        await apoderadoRepositoryInterface.getAlumnosFromApoderado(id);
    return apoderadoAlumnosFromJson(response.body);
  }

  Future<List<AlumnoMateria>> getAlumnoMaterias(int idAlumuno) async {
    final response =
        await apoderadoRepositoryInterface.getAlumnoMaterias(idAlumuno);
    return alumnoMateriaFromJson(response.body);
  }

  Future<List<ApoderadoNofiticacion>> getNotificaciones() async {
    final id = await localRepositoryInterface.getUser();
    final response = await apoderadoRepositoryInterface.getNotificaciones(id);
    return apoderadoNofiticacionFromJson(response.body);
  }

  Future<void> marcarVisto(int idTareaAlumno) async {
    await apoderadoRepositoryInterface.marcarVisto(idTareaAlumno);
  }

  Future<List<ApoderadoTareasAlumno>> getTareasAlumno(int idAlumno) async {
    final response =
        await apoderadoRepositoryInterface.getTareasFromAlumno(idAlumno);
    return apoderadoTareasAlumnoFromJson(response.body);
  }
}
