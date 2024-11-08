import 'package:agenda_electronica/domain/response/apoderado_notificacion.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApoderadoVerTareaScreen extends StatefulWidget {
  const ApoderadoVerTareaScreen(
      {super.key, required this.apoderadoNofiticacion});
  final ApoderadoNofiticacion apoderadoNofiticacion;

  @override
  State<ApoderadoVerTareaScreen> createState() =>
      _ApoderadoVerTareaScreenState();
}

class _ApoderadoVerTareaScreenState extends State<ApoderadoVerTareaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Tarea",
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.apoderadoNofiticacion.titulo,
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
                          "Descripcion: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          widget.apoderadoNofiticacion.descripcion,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Profesor: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          widget.apoderadoNofiticacion.profesorNombre,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Materia: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          widget.apoderadoNofiticacion.materiaNombre,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fecha de Pesentacion: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.apoderadoNofiticacion.fechaPresentacion
                              .toString()
                              .split(" ")[0],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
