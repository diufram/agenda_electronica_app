import 'package:agenda_electronica/domain/response/alumno_asistencia_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_notifications_screen.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfesorAsistenciasScreen extends StatelessWidget {
  const ProfesorAsistenciasScreen({super.key, required this.idMateria});
  final int idMateria;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfesorBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Asistencias",
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
        child: FutureBuilder<List<AlumnoAsistencia>>(
            future: bloc.getAsistenciasFromMateria(idMateria),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Mientras el future está cargando
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Si ocurrió un error
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text("No hay Asistencias Aun"));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length, // Cantidad de elementos
                  itemBuilder: (context, index) {
                    final asistencia = snapshot.data![index];

                    return InkWell(
                        onTap: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfesorMateriaScreen(
                                      cursoId: profesorCurso.cursoId))); */
                        },
                        child: AsistenciaDetalle(
                          alumnoAsistencia: asistencia,
                        ));
                  },
                );
              } else {
                // Si no hay datos
                return const Center(child: Text("No hay Asistencias Aun"));
              }
            }),
      ),
    );
  }
}

class AsistenciaDetalle extends StatelessWidget {
  const AsistenciaDetalle({
    super.key,
    required this.alumnoAsistencia,
  });

  final AlumnoAsistencia alumnoAsistencia;

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
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(alumnoAsistencia.fecha.toString().split(" ")[0],
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cantidad de Alumnos Presentes:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(alumnoAsistencia.cantAlumnosPresentes.toString(),
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          )),
    );
  }
}
