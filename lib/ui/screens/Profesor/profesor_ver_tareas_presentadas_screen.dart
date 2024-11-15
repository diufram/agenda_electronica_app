import 'package:agenda_electronica/domain/response/profesor_tarea_presentada_response.dart';
import 'package:agenda_electronica/domain/response/profesor_tareas_materia_response.dart';
import 'package:agenda_electronica/services/globals.dart';

import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_ver_tarea_presentada_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfesorVerTareasPresentadasScreen extends StatelessWidget {
  const ProfesorVerTareasPresentadasScreen({super.key, required this.idTarea});

  final int idTarea;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProfesorBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Tareas Presentadas",
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
        child: FutureBuilder<List<ProfesorTareaPresentada>>(
          future: bloc.getTareasPresentadas(idTarea),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mientras el future está cargando
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Si ocurrió un error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No presentaron Tareas Aun"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length, // Cantidad de elementos
                itemBuilder: (context, index) {
                  final profesorTareasMateria = snapshot.data![index];

                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfesorVerTareaPresentadaScreen(
                                      tarea: profesorTareasMateria,
                                    )));
                      },
                      child: TareaDetalle(
                        profesorTareaPresentada: profesorTareasMateria,
                      ));
                },
              );
            } else {
              // Si no hay datos
              return const Center(child: Text("No presentaron Tareas Aun"));
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
    required this.profesorTareaPresentada,
  });

  final ProfesorTareaPresentada profesorTareaPresentada;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
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
        height: 80.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nombre:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(profesorTareaPresentada.alumnoNombre,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nota:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(profesorTareaPresentada.nota.toString(),
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
