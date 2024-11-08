import 'package:agenda_electronica/domain/response/apoderado_alumnos_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_notifications_screen.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_bloc.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_materia_hijo_screen.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_notificacion_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ApoderadoScreen extends StatelessWidget {
  const ApoderadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ApoderadoBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Tus Hijos",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications_on_outlined,
              color: Colors.white, // Asegúrate de que el color sea visible
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ApoderadoNotificacionScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<ApoderadoAlumnos>>(
          future: bloc.getAlumnosFromApoderado(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mientras el future está cargando
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Si ocurrió un error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No se Asignaron Alumnos Aun"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length, // Cantidad de elementos
                itemBuilder: (context, index) {
                  final alumno = snapshot.data![index];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ApoderadoMateriaHijoScreen(
                                      idAlumno: alumno.alumnoId,
                                    )));
                      },
                      child: AlumnoDetalle(
                        apoderadoAlumno: alumno,
                      ));
                },
              );
            } else {
              // Si no hay datos
              return const Center(child: Text("No se Asignaron Alumnos Aun"));
            }
          },
        ),
      ),
    );
  }
}

class AlumnoDetalle extends StatelessWidget {
  const AlumnoDetalle({
    super.key,
    required this.apoderadoAlumno,
  });
  final ApoderadoAlumnos apoderadoAlumno;

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
        height: 80.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(apoderadoAlumno.alumnoNombre,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Curso:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(apoderadoAlumno.cursoNombre,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
