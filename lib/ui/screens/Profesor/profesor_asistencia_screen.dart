import 'package:agenda_electronica/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfesorAsistenciaScreen extends StatefulWidget {
  const ProfesorAsistenciaScreen({super.key});

  @override
  State<ProfesorAsistenciaScreen> createState() =>
      _ProfesorAsistenciaScreenState();
}

class _ProfesorAsistenciaScreenState extends State<ProfesorAsistenciaScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.save_outlined,
                color: Colors.white,
                size: 30.sp,
              ))
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.only(
                    right: 10.sp, left: 10.sp, top: 5.sp, bottom: 5.sp),
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundSecondary, // Color del container
                    borderRadius:
                        BorderRadius.circular(8.sp), // Esquinas redondeadas
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.5.sp), // Color de la sombra
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                            0, 3), // Cambia la posición de la sombra
                      ),
                    ],
                  ),
                  height: 80.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CheckboxListTile(
                        activeColor: Colors.green
                            .shade700, // Color del checkbox cuando está marcado
                        checkColor: Colors.white,

                        title: Text("Luis David Fernandez",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, // Ubica el checkbox antes del texto
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
