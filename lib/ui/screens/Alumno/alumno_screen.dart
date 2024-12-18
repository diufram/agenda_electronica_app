import 'package:agenda_electronica/domain/repository/alumno_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/response/alumno_materia_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_bloc.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_generar_horario_screen.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_horario_generado_screen.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_tareas_screen.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_notifications_screen.dart';
import 'package:agenda_electronica/ui/screens/login/login_screnn.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AlumnoScreen extends StatelessWidget {
  const AlumnoScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlumnoBloc(
          alumnoRepositoryInterface: context.read<AlumnoRepositoryInterface>(),
          localRepositoryInterface: context.read<LocalRepositoryInterface>()),
      builder: (_, __) => const AlumnoScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AlumnoBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Tus Materias",
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
              //color: Colors.white, // Asegúrate de que el color sea visible
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AlumnoNotificationsScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Cabecera del Drawer
            DrawerHeader(
              decoration: const BoxDecoration(
                color: backgroundPrimary,
              ),
              child: Text(
                'Agenda Electronica',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
            // Opciones del Drawer
            ListTile(
              leading: const Icon(Icons.book),
              title: Text(
                'Generar Horario de Estudio',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlumnoGenerarHorarioScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_added_outlined),
              title: const Text('Horario Generado'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlumnoHorarioGeneradoScreen()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScrenn()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<AlumnoMateria>>(
          future: bloc.getAlumnoMaterias(),
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
                    child: Text("No se Asignaron Materias Aun"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length, // Cantidad de elementos
                itemBuilder: (context, index) {
                  final alumnoMateria = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlumnoTareasScreen(
                                    idMateria: alumnoMateria.id,
                                  )));
                    },
                    child: MateriaDetalle(
                      alumnoMateria: alumnoMateria,
                    ),
                  );
                },
              );
            } else {
              // Si no hay datos
              return const Center(child: Text("No se Asignaron Materias Aun"));
            }
          },
        ),
      ),
    );
  }
}

class MateriaDetalle extends StatelessWidget {
  const MateriaDetalle({
    super.key,
    required this.alumnoMateria,
  });
  final AlumnoMateria alumnoMateria;

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
          height: 170.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(alumnoMateria.materiaNombre,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Profesor",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(alumnoMateria.profesorNombre,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Text("Progreso:",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              LinearProgressIndicator(
                value:
                    0.5, // Valor de progreso entre 0.0 y 1.0 (50% en este caso)
                minHeight: 8.sp, // Altura de la barra
                backgroundColor: Colors.grey[300], // Color de fondo de la barra
                valueColor: const AlwaysStoppedAnimation<Color>(
                    backgroundPrimary), // Color de la barra
              ),
            ],
          )),
    );
  }
}
