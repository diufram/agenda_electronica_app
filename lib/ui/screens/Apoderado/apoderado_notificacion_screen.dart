import 'package:agenda_electronica/domain/response/apoderado_notificacion.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_bloc.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_ver_tarea_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ApoderadoNotificacionScreen extends StatelessWidget {
  const ApoderadoNotificacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ApoderadoBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Notifiaciones",
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
        child: FutureBuilder<List<ApoderadoNofiticacion>>(
          future: bloc.getNotificaciones(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mientras el future está cargando
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Si ocurrió un error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No hay notificaciones Aun"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length, // Cantidad de elementos
                itemBuilder: (context, index) {
                  final notificacion = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      bloc.marcarVisto(notificacion.tareaId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApoderadoVerTareaScreen(
                                    apoderadoNofiticacion: notificacion,
                                  )));
                    },
                    child: NotificacionDetalle(
                      apoderadoNofiticacion: notificacion,
                    ),
                  );
                },
              );
            } else {
              // Si no hay datos
              return const Center(child: Text("No Hay notificaciones Aun"));
            }
          },
        ),
      ),
    );
  }
}

class NotificacionDetalle extends StatelessWidget {
  const NotificacionDetalle({
    super.key,
    required this.apoderadoNofiticacion,
  });

  final ApoderadoNofiticacion apoderadoNofiticacion;

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
        height: 120.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Materia:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(apoderadoNofiticacion.materiaNombre,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Profesor:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(apoderadoNofiticacion.profesorNombre,
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
                Text(apoderadoNofiticacion.descripcion,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hijo:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(apoderadoNofiticacion.alumnoNombre,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
