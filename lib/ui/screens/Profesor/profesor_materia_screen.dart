import 'package:agenda_electronica/domain/response/profesor_materias_curso.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_tareas_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfesorMateriaScreen extends StatelessWidget {
  const ProfesorMateriaScreen({super.key, required this.cursoId});
  final int cursoId;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProfesorBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Materias",
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
        child: FutureBuilder<List<ProfesorMateriasCurso>>(
          future: bloc.getMateriasFromCursos(cursoId),
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
                  final profesorMateriaCurso = snapshot.data![index];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfesorTareasScreen(
                                      idMateriaHorario: profesorMateriaCurso.id,
                                    )));
                      },
                      child: MateriaDetalle(
                        profesorMateriasCurso: profesorMateriaCurso,
                      ));
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
    required this.profesorMateriasCurso,
  });

  final ProfesorMateriasCurso profesorMateriasCurso;

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
          height: 170.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profesorMateriasCurso.materiaNombre,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dias:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text("Lun Mier Vie",
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Horario:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(profesorMateriasCurso.horario,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cantidad de Alumos:",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(profesorMateriasCurso.cantidadAlumnos.toString(),
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          )),
    );
  }
}
