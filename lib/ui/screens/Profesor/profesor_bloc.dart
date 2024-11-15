import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/request/tarea_request.dart';
import 'package:agenda_electronica/domain/response/alumno_asistencia_response.dart';
import 'package:agenda_electronica/domain/response/profesor_tarea_presentada_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:agenda_electronica/domain/repository/profesor_repository_intr.dart';
import 'package:agenda_electronica/domain/response/profesor_alumnos_materia_response.dart';
import 'package:agenda_electronica/domain/response/profesor_cursos_response.dart';
import 'package:agenda_electronica/domain/response/profesor_materias_curso.dart';
import 'package:agenda_electronica/domain/response/profesor_tareas_materia_response.dart';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class ProfesorBloc extends ChangeNotifier {
  ProfesorRepositoryInterface profesorRepositoryInterface;
  LocalRepositoryInterface localRepositoryInterface;
  ProfesorBloc(
      {required this.profesorRepositoryInterface,
      required this.localRepositoryInterface});

  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController fechaPesentacionController = TextEditingController();

  TextEditingController notaController = TextEditingController();

  File? archivoSeleccionado;

  DateTime? fechaPresentacion;

  List<int> alumnosPresentes = [];

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

  Future<List<AlumnoAsistencia>> getAsistenciasFromMateria(
      int idMateria) async {
    final response =
        await profesorRepositoryInterface.getAsistenciasFromMateria(idMateria);
    return alumnoAsistenciaFromJson(response.body);
  }

  Future<void> createAsistencia(int idMateria) async {
    await profesorRepositoryInterface.createAsistencia(
        idMateria, alumnosPresentes);
    clearAsistencia();
    notifyListeners();
  }

  void addAlumnosPresentes(int idAlumno) {
    alumnosPresentes.add(idAlumno);
    notifyListeners();
  }

  void removeAlumnosPresentes(int idAlumno) {
    alumnosPresentes.remove(idAlumno);
    notifyListeners();
  }

  bool containsAlumno(int idAlumno) {
    return alumnosPresentes.contains(idAlumno);
  }

  void clearAsistencia() {
    alumnosPresentes.clear();
    notifyListeners();
  }

  Future<List<ProfesorTareaPresentada>> getTareasPresentadas(
      int idTarea) async {
    final response =
        await profesorRepositoryInterface.getTareasPresentadas(idTarea);
    return profesorTareaPresentadaFromJson(response.body);
  }

  Future<void> getArchivoFromTarea(int idTareaAlumno) async {
    final response =
        await profesorRepositoryInterface.getArchivoTarea(idTareaAlumno);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final tarea = data['tarea'];
      final String? archivoNombre = tarea['archivo_nombre'];
      final String? archivoDatos = tarea['archivo_datos'];

      if (archivoNombre != null && archivoDatos != null) {
        // Decodificar el archivo desde base64
        final bytes = base64Decode(archivoDatos);

        // Obtener la ruta para guardar el archivo
        final directory = await getApplicationDocumentsDirectory();
        final filePath = join(directory.path, archivoNombre);

        // Guardar el archivo en el almacenamiento local
        final file = File(filePath);
        await file.writeAsBytes(bytes);
        OpenFile.open(filePath);
      }
    }
  }

  Future<void> asignarNota(int idTareaAlumno) async {
    profesorRepositoryInterface.asignarNota(
        idTareaAlumno, double.parse(notaController.text));

    notaController.clear();
  }
}
