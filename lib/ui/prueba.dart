import 'package:agenda_electronica/services/globals.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Prueba extends StatelessWidget {
  const Prueba({super.key});

  Future<void> descargarArchivoDeTarea(int tareaId) async {
    final url = Uri.parse("${baseURL}alumno/tarea/$tareaId");

    // Realizar la solicitud GET a la API
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
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

          print("Archivo descargado en: $filePath");
        } else {
          print("No se encontró un archivo adjunto en esta tarea.");
        }
      } else {
        print("Error: ${data['message']}");
      }
    } else {
      print("Error al obtener los datos de la tarea: ${response.statusCode}");
    }
  }

  void abrirArchivo(String filePath) {
    OpenFile.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await descargarArchivoDeTarea(15);
            },
            child: Text("GET")),
      ),
    );
  }
}
