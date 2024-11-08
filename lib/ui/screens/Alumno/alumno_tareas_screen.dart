import 'package:agenda_electronica/domain/response/alumno_tareas_materia_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_bloc.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_tarea_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AlumnoTareasScreen extends StatelessWidget {
  const AlumnoTareasScreen({super.key, required this.idMateria});
  final int idMateria;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AlumnoBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Tareas",
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
        child: FutureBuilder<List<AlumnoTareasMateria>>(
          future: bloc.getTareasFromMateria(idMateria),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mientras el future está cargando
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Si ocurrió un error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No se Asignaron Tareas Aun"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length, // Cantidad de elementos
                itemBuilder: (context, index) {
                  final alumnoTarea = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlumnoTareaScreen(
                                    alumnoTareaMateria: alumnoTarea,
                                  )));
                    },
                    child: TareaDetalle(
                      alumnoTareasMateria: alumnoTarea,
                    ),
                  );
                },
              );
            } else {
              // Si no hay datos
              return const Center(child: Text("No se Asignaron Tareas Aun"));
            }
          },
        ),
      ),
    );
  }
}

class TareaDetalle extends StatelessWidget {
  const TareaDetalle({
    super.key,
    required this.alumnoTareasMateria,
  });
  final AlumnoTareasMateria alumnoTareasMateria;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: backgroundSecondary, // Color del container
          borderRadius: BorderRadius.circular(8.sp), // Esquinas redondeadas
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Color de la sombra
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // Cambia la posición de la sombra
            ),
          ],
        ),
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Titulo:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(alumnoTareasMateria.titulo,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Fecha de Presentacion:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(
                    alumnoTareasMateria.fechaPresentacion
                        .toString()
                        .split(" ")[0],
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
