import 'package:agenda_electronica/domain/response/alumno_materia_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_screen.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_bloc.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_tarea_hijo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApoderadoMateriaHijoScreen extends StatelessWidget {
  const ApoderadoMateriaHijoScreen({super.key, required this.idAlumno});
  final int idAlumno;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ApoderadoBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Sus Materias",
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
        child: FutureBuilder<List<AlumnoMateria>>(
          future: bloc.getAlumnoMaterias(idAlumno),
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
                  print(idAlumno);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApoderadoTareaHijoScreen(
                                    idAlumno: idAlumno,
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
