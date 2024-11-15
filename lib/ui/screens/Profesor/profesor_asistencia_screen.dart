import 'package:agenda_electronica/domain/response/profesor_alumnos_materia_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfesorAsistenciaScreen extends StatelessWidget {
  const ProfesorAsistenciaScreen({super.key, required this.idMateriaHorario});

  final int idMateriaHorario;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfesorBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Lista de Asistencia",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            bloc.clearAsistencia();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                // Guardar los datos de asistencia aquí

                await bloc.createAsistencia(idMateriaHorario);
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfesorScreen.init(context)),
                    (Route<dynamic> route) =>
                        false, // Aquí defines el predicado
                  );
                }
              },
              icon: Icon(
                Icons.save_outlined,
                color: Colors.white,
                size: 30.sp,
              ))
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<ProfesorAlumnosMateria>>(
          future: bloc.getAlumnosFromMateria(idMateriaHorario),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No se Asignaron Alumnos Aun"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  final alumno = snapshot.data![i];
                  bool isChecked =
                      context.watch<ProfesorBloc>().containsAlumno(alumno.id);
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 10.sp,
                      left: 10.sp,
                      top: 5.sp,
                      bottom: 5.sp,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundSecondary,
                        borderRadius: BorderRadius.circular(8.sp),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 80.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CheckboxListTile(
                            activeColor: Colors.green.shade700,
                            checkColor: Colors.white,
                            title: Text(
                              alumno.nombre,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            value: isChecked,
                            onChanged: (bool? value) {
                              if (value == true) {
                                // Agregar el ID del alumno si está marcado
                                bloc.addAlumnosPresentes(alumno.id);
                              } else {
                                // Remover el ID del alumno si está desmarcado
                                bloc.removeAlumnosPresentes(alumno.id);
                              }
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No se Asignaron Alumnos Aun"));
            }
          },
        ),
      ),
    );
  }
}
