import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_screen.dart';
import 'package:agenda_electronica/ui/widget/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfesorTareaCrearScreen extends StatelessWidget {
  const ProfesorTareaCrearScreen({super.key, required this.idMateria});
  final int idMateria;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfesorBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Crear Tarea",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            bloc.clearAll();
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
            child: Column(
              children: [
                CustomTextField(
                  textController: bloc.tituloController,
                  isObscureText: false,
                  hintText: "Titulo",
                  type: TextInputType.text,
                  width: MediaQuery.sizeOf(context).width * 0.97,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  textController: bloc.descripcionController,
                  isObscureText: false,
                  hintText: "Descripcion",
                  maxLines: 3,
                  type: TextInputType.text,
                  width: MediaQuery.sizeOf(context).width * 0.97,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  textController: bloc.fechaPesentacionController,
                  isObscureText: false,
                  hintText: "Fecha Presentacion",
                  readOnly: true,
                  type: TextInputType.text,
                  width: MediaQuery.sizeOf(context).width * 0.97,
                  onTap: () => bloc.selectFechaPresentacion(context),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Consumer<ProfesorBloc>(
                  builder: (context, counter, child) {
                    return bloc.archivoSeleccionado == null
                        ? const Text("")
                        : Text(
                            bloc.getNameArchivo(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                    ),
                          );
                  },
                ),
                ElevatedButton(
                  onPressed: bloc.seleccionarArchivo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        backgroundSecondary, // Cambia el color de fondo
                  ),
                  child: Text(
                    'Seleccionar Archivos',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 15.sp,
            bottom: 15.sp,
            child: ElevatedButton(
              onPressed: () async {
                await context.read<ProfesorBloc>().createTarea(idMateria);
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
                shape: const CircleBorder(),
                padding: EdgeInsets.all(20.sp), // Ajusta el tamaño del botón
                backgroundColor:
                    backgroundPrimary, // Cambia el color de fondo si lo deseas
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white, // Cambia el color del ícono si lo deseas
              ),
            ),
          ),
        ],
      )),
    );
  }
}
