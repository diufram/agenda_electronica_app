import 'package:agenda_electronica/domain/repository/alumno_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/response/alumno_materia_response.dart';
import 'package:agenda_electronica/domain/response/alumno_tareas_materia_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class AlumnoBloc extends ChangeNotifier {
  AlumnoRepositoryInterface alumnoRepositoryInterface;
  LocalRepositoryInterface localRepositoryInterface;
  AlumnoBloc(
      {required this.alumnoRepositoryInterface,
      required this.localRepositoryInterface});
  File? archivoSeleccionado;
  Future<List<AlumnoMateria>> getAlumnoMaterias() async {
    final id = await localRepositoryInterface.getUser();

    final response = await alumnoRepositoryInterface.getAlumnoMaterias(id);
    return alumnoMateriaFromJson(response.body);
  }

  Future<List<AlumnoTareasMateria>> getTareasFromMateria(int idMateria) async {
    final response =
        await alumnoRepositoryInterface.getAlumnoDeberes(idMateria);
    return alumnoTareasMateriaFromJson(response.body);
  }

  Future<void> getArchivoFromTarea(int idTarea) async {
    final response = await alumnoRepositoryInterface.getArchivoTarea(idTarea);
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

  Future<void> presentarTarea(int idTarea) async {
    final id = await localRepositoryInterface.getUser();
    await alumnoRepositoryInterface.presentarTarea(
        idTarea, id, archivoSeleccionado!);
  }
}
