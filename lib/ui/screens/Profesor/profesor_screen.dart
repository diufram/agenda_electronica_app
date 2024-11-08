import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/profesor_repository_intr.dart';
import 'package:agenda_electronica/domain/response/profesor_cursos_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_notifications_screen.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_materia_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfesorScreen extends StatelessWidget {
  const ProfesorScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfesorBloc(
          profesorRepositoryInterface:
              context.read<ProfesorRepositoryInterface>(),
          localRepositoryInterface: context.read<LocalRepositoryInterface>()),
      builder: (_, __) => const ProfesorScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProfesorBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Cursos",
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
                      builder: (context) => const AlumnoNotificationsScreen()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<ProfesorCursos>>(
            future: bloc.getCursos(),
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
                    final profesorCurso = snapshot.data![index];

                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfesorMateriaScreen(
                                      cursoId: profesorCurso.cursoId)));
                        },
                        child: CursoDetalle(
                          profesorCursos: profesorCurso,
                        ));
                  },
                );
              } else {
                // Si no hay datos
                return const Center(child: Text("No se Asignaron Cursos Aun"));
              }
            }),
      ),
    );
  }
}

class CursoDetalle extends StatelessWidget {
  const CursoDetalle({
    super.key,
    required this.profesorCursos,
  });

  final ProfesorCursos profesorCursos;

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
              Text(profesorCursos.cursoNombre,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Paralelo:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(profesorCursos.cursoParalelo,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          )),
    );
  }
}
