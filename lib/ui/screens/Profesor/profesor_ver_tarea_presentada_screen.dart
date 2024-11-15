import 'package:agenda_electronica/domain/response/profesor_tarea_presentada_response.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_screen.dart';
import 'package:agenda_electronica/ui/widget/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfesorVerTareaPresentadaScreen extends StatelessWidget {
  const ProfesorVerTareaPresentadaScreen({super.key, required this.tarea});

  final ProfesorTareaPresentada tarea;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ProfesorBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Tareas Presentada de:",
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
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              Text(
                tarea.alumnoNombre,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Nota Actual:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text("${tarea.nota.toString()} / 100",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              SizedBox(
                height: 15.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Archivo Presentado: ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await context
                          .read<ProfesorBloc>()
                          .getArchivoFromTarea(tarea.tareaAlumnoId);
                    },
                    child: Text(
                      tarea.archivoNombre,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.sp,
              ),
              CustomTextField(
                  textController: bloc.notaController,
                  isObscureText: false,
                  hintText: "Nota a Asignar",
                  type: TextInputType.number,
                  width: MediaQuery.sizeOf(context).width),
              SizedBox(
                height: 15.sp,
              ),
              ElevatedButton(
                onPressed: () async {
                  await bloc.asignarNota(tarea.tareaAlumnoId);
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
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      backgroundSecondary, // Cambia el color de fondo
                ),
                child: Text(
                  'Agregar Nota',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(height: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
