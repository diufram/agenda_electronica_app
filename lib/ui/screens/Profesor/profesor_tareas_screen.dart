import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_tarea_screen.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_asistencia_screen.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_tarea_crear_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfesorTareasScreen extends StatelessWidget {
  const ProfesorTareasScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: <Widget>[
          PopupMenuButton<String>(
            color: backgroundOptional,
            elevation: 10.sp,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
            onSelected: (value) {
              if (value == "1") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ProfesorAsistenciaScreen()));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: '1',
                  child: ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: Text(
                      'Tomar Asistencia',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: '2',
                  child: ListTile(
                    leading: const Icon(Icons.group_outlined),
                    title: Text(
                      'Historial de Asistencia',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: '2',
                  child: ListTile(
                    leading: const Icon(
                      Icons.attach_file_rounded,
                    ),
                    title: Text(
                      'Crear Tarea',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AlumnoTareaScreen()));
              },
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  decoration: BoxDecoration(
                    color: backgroundSecondary, // Color del container
                    borderRadius:
                        BorderRadius.circular(8.sp), // Esquinas redondeadas
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.5), // Color de la sombra
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                            0, 3), // Cambia la posición de la sombra
                      ),
                    ],
                  ),
                  height: 130.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Titulo:",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Text("Metricas de un software",
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
                          Text("10 sept 2020",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cantidad de Pesentados:",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Text("10",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
