import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_notifications_screen.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_tarea_hijo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApoderadoMateriaHijoScreen extends StatelessWidget {
  const ApoderadoMateriaHijoScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ApoderadoTareaHijoScreen()));
                },
                child: Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: backgroundSecondary, // Color del container
                      borderRadius:
                          BorderRadius.circular(8.sp), // Esquinas redondeadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Color de la sombra
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(
                              0, 3), // Cambia la posición de la sombra
                        ),
                      ],
                    ),
                    height: 130.sp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Matematicas",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Profesor:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Text("Matias Franco",
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
                          backgroundColor:
                              Colors.grey[300], // Color de fondo de la barra
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              backgroundPrimary), // Color de la barra
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
