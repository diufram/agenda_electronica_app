import 'dart:io';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/request/tarea_request.dart';
import 'package:file_picker/file_picker.dart';
import 'package:agenda_electronica/domain/repository/profesor_repository_intr.dart';
import 'package:agenda_electronica/domain/response/profesor_alumnos_materia_response.dart';
import 'package:agenda_electronica/domain/response/profesor_cursos_response.dart';
import 'package:agenda_electronica/domain/response/profesor_materias_curso.dart';
import 'package:agenda_electronica/domain/response/profesor_tareas_materia_response.dart';

import 'package:flutter/material.dart';

class ProfesorBloc extends ChangeNotifier {
  ProfesorRepositoryInterface profesorRepositoryInterface;
  LocalRepositoryInterface localRepositoryInterface;
  ProfesorBloc(
      {required this.profesorRepositoryInterface,
      required this.localRepositoryInterface});

  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController fechaPesentacionController = TextEditingController();

  File? archivoSeleccionado;

  DateTime? fechaPresentacion;

  Future<List<ProfesorCursos>> getCursos() async {
    final id = await localRepositoryInterface.getUser();
    final response = await profesorRepositoryInterface.getCursosProfesor(id);
    return profesorCursosFromJson(response.body);
  }

  Future<List<ProfesorMateriasCurso>> getMateriasFromCursos(int cursoId) async {
    final id = await localRepositoryInterface.getUser();
    final response =
        await profesorRepositoryInterface.getMateriasFromCurso(id, cursoId);
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

  Future<void> selectFechaPresentacion(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(2000), // Fecha mínima
      lastDate: DateTime(2100), // Fecha máxima
    );
    if (picked != null && picked != fechaPresentacion) {
      fechaPresentacion = picked;

      fechaPesentacionController.text = picked.toString().split(" ")[0];
      notifyListeners();
    }
  }

  Future<void> seleccionarArchivo() async {
    // Abre el selector de archivos
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    // Verifica si se seleccionó un archivo
    if (result != null) {
      // Obtiene el archivo como un objeto File
      File arc = File(result.files.single.path!);
      archivoSeleccionado = arc;
      notifyListeners();
    }
  }

  getNameArchivo() {
    return archivoSeleccionado!.path.split("/")[7];
  }

  Future<void> createTarea(int idMateriaHorario) async {
    final tarea = TareaRequest(
        titulo: tituloController.text,
        descripcion: descripcionController.text,
        fechaPesentacion: fechaPesentacionController.text,
        archivo: archivoSeleccionado!);
    await profesorRepositoryInterface.createTarea(idMateriaHorario, tarea);
    clearAll();
  }

  void clearAll() {
    tituloController.clear();
    descripcionController.clear();
    fechaPesentacionController.clear();
    archivoSeleccionado = null;
  }
}
