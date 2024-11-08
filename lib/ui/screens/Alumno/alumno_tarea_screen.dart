import 'package:agenda_electronica/domain/response/alumno_tareas_materia_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_bloc.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AlumnoTareaScreen extends StatelessWidget {
  const AlumnoTareaScreen({super.key, required this.alumnoTareaMateria});
  final AlumnoTareasMateria alumnoTareaMateria;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlumnoBloc>();
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  Text(
                    alumnoTareaMateria.titulo,
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
                        alumnoTareaMateria.descripcion,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Archivo Compartido: ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      GestureDetector(
                        onTap: () async {
                          //print(widget.alumnoTareaMateria.id);
                          await context
                              .read<AlumnoBloc>()
                              .getArchivoFromTarea(alumnoTareaMateria.id);
                        },
                        child: Text(
                          alumnoTareaMateria.archivoNombre,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.blueAccent,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
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
                        alumnoTareaMateria.fechaPresentacion
                            .toString()
                            .split(" ")[0],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Consumer<AlumnoBloc>(
                    builder: (context, counter, child) {
                      return bloc.archivoSeleccionado == null
                          ? const Text("")
                          : Column(
                              children: [
                                Text(
                                  bloc.getNameArchivo(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                      ),
                                )
                              ],
                            );
                    },
                  ),
                  ElevatedButton(
                    onPressed: bloc.seleccionarArchivo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          backgroundSecondary, // Cambia el color de fondo
                    ),
                    child: Text(
                      'Selecciona un Archivo para Presentar',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(height: 20.sp),
                ],
              ),
            ),
            Positioned(
              right: 15.sp,
              bottom: 15.sp,
              child: ElevatedButton(
                onPressed: () async {
                  //await bloc.presentarTarea();
                  print(alumnoTareaMateria.id);
                  await bloc.presentarTarea(alumnoTareaMateria.id);
                  /* if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlumnoScreen.init(context)),
                      (Route<dynamic> route) =>
                          false, // Aquí defines el predicado
                    );
                  } */
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.all(20.sp), // Ajusta el tamaño del botón
                  backgroundColor:
                      backgroundPrimary, // Cambia el color de fondo si lo deseas
                ),
                child: const Icon(
                  Icons.save,
                  color: Colors.white, // Cambia el color del ícono si lo deseas
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
