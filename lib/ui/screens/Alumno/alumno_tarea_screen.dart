import 'package:agenda_electronica/domain/response/alumno_tareas_materia_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class AlumnoTareaScreen extends StatefulWidget {
  const AlumnoTareaScreen({super.key, required this.alumnoTareaMateria});
  final AlumnoTareasMateria alumnoTareaMateria;

  @override
  State<AlumnoTareaScreen> createState() => _AlumnoTareaScreenState();
}

class _AlumnoTareaScreenState extends State<AlumnoTareaScreen> {
  List<String?> _filePaths = [];

  // Función para seleccionar múltiples archivos
  Future<void> _pickMultipleFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'mp3',
        'mp4',
        'pdf',
        'jpg',
        'png'
      ], // Puedes agregar más extensiones
    );

    if (result != null) {
      setState(() {
        _filePaths =
            result.paths; // Almacena las rutas de los archivos seleccionados
      });
    } else {
      print('No se seleccionaron archivos');
    }
  }

  // Función para subir un archivo al servidor
  Future<void> _uploadFile(String filePath) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://ejemplo.com/upload'), // Cambia a tu URL de destino
    );

    // Adjuntar el archivo
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      filePath,
    ));

    // Enviar la solicitud
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Archivo subido exitosamente.');
    } else {
      print('Error al subir archivo.');
    }
  }

  // Función para subir múltiples archivos
  Future<void> _uploadMultipleFiles() async {
    for (String? path in _filePaths) {
      if (path != null) {
        await _uploadFile(path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Tarea",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  widget.alumnoTareaMateria.titulo,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Descripcion: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      widget.alumnoTareaMateria.descripcion,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fecha de Pesentacion: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.alumnoTareaMateria.fechaPresentacion
                          .toString()
                          .split(" ")[0],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _pickMultipleFiles,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        backgroundSecondary, // Cambia el color de fondo
                  ),
                  child: Text(
                    'Seleccionar Archivos',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SizedBox(height: 20.sp),
                if (_filePaths.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        'Archivos seleccionados:',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      for (String? path in _filePaths)
                        Text(
                          path ?? 'Archivo no válido',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      SizedBox(height: 20.sp),
                      ElevatedButton(
                        onPressed:
                            _uploadMultipleFiles, // Sube los archivos seleccionados
                        child: Text(
                          'Subir Archivos',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
