import 'dart:io';

class TareaRequest {
  final String titulo;
  final String descripcion;
  final String fechaPesentacion;
  final File archivo;
  TareaRequest(
      {required this.titulo,
      required this.descripcion,
      required this.fechaPesentacion,
      required this.archivo});
}
