import 'package:agenda_electronica/domain/response/apoderado_tarea_alumno_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ApoderadoTareaHijoScreen extends StatelessWidget {
  const ApoderadoTareaHijoScreen({super.key, required this.idAlumno});
  final int idAlumno;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ApoderadoBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Sus Tareas",
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
        child: FutureBuilder<List<ApoderadoTareasAlumno>>(
          future: bloc.getTareasAlumno(idAlumno),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mientras el future está cargando
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Si ocurrió un error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("No hay Tareas Pendientes Aun"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length, // Cantidad de elementos
                itemBuilder: (context, index) {
                  final tarea = snapshot.data![index];
                  return TareaAlumnoDetalle(
                    apoderadoTareasAlumno: tarea,
                  );
                },
              );
            } else {
              // Si no hay datos
              return const Center(child: Text("No Hay Tareas pendientes Aun"));
            }
          },
        ),
      ),
    );
  }
}

class TareaAlumnoDetalle extends StatelessWidget {
  const TareaAlumnoDetalle({
    super.key,
    required this.apoderadoTareasAlumno,
  });
  final ApoderadoTareasAlumno apoderadoTareasAlumno;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: apoderadoTareasAlumno.estado
              ? backgroundSecondary
              : Colors.red.shade100, // Color del container
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
        height: 100.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Fecha de Presentacion:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(
                    apoderadoTareasAlumno.fechaPresentacion
                        .toString()
                        .split(' ')[0],
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Descripcion:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(apoderadoTareasAlumno.descripcion,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Estado:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(apoderadoTareasAlumno.estado ? 'Presentado' : 'Pendiente',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
