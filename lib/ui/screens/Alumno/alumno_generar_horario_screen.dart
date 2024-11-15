import 'dart:convert';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_bloc.dart';
import 'package:agenda_electronica/ui/widget/widget/custom_textfield.dart';
import 'package:agenda_electronica/ui/widget/widget/loading_modal.dart';
import 'package:agenda_electronica/ui/widget/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AlumnoGenerarHorarioScreen extends StatefulWidget {
  AlumnoGenerarHorarioScreen({super.key});

  @override
  State<AlumnoGenerarHorarioScreen> createState() =>
      _AlumnoGenerarHorarioScreenState();
}

class _AlumnoGenerarHorarioScreenState
    extends State<AlumnoGenerarHorarioScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlumnoBloc>();
    TimeOfDay _selectedTime = TimeOfDay.now();

    Future<void> generarHorario() async {
      loading(context);
      final response = await bloc.generarHorario();

      if (response) {
        if (context.mounted) Navigator.pop(context);
      } else {
        if (context.mounted) Navigator.pop(context);
        toast("Ocurrio un error intentelo nuevamente");
      }
    }

    Widget _buildScheduleTable(String jsonString) {
      try {
        // Decodificar el JSON
        final Map<String, dynamic> schedule = jsonDecode(jsonString);

        // Obtener los días dinámicamente desde las claves del JSON
        final List<String> daysOfWeek = ['Hora', ...schedule.keys];

        // Encuentra el máximo número de materias en un día
        final int maxSubjects = schedule.values
            .map((day) => day.length)
            .reduce((a, b) => a > b ? a : b);

        // Construir la tabla
        return Table(
          defaultColumnWidth:
              const FixedColumnWidth(150), // Ajusta ancho fijo por columna
          border: TableBorder.all(color: Colors.black, width: 1),
          children: [
            // Encabezados dinámicos
            TableRow(
              children: daysOfWeek
                  .map((day) => TableCell(
                        child: Container(
                          color: Colors.blue[100],
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              day,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            // Filas dinámicas
            for (int i = 0; i < maxSubjects; i++)
              TableRow(
                children: daysOfWeek.map((day) {
                  if (day == 'Hora') {
                    // Rango de horas (puedes personalizarlo según las materias)
                    return TableCell(
                      child: Center(
                        child: Text(
                          '${14 + i}:00 - ${14 + i}:40', // Horas ficticias
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (schedule.containsKey(day)) {
                    final subjects = schedule[day];
                    if (i < subjects.length) {
                      final subject = subjects[i];
                      return TableCell(
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              subject['Materia'],
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const TableCell(
                          child: Center(child: Text(''))); // Celda vacía
                    }
                  } else {
                    return const TableCell(
                        child: Center(child: Text(''))); // Celda vacía
                  }
                }).toList(),
              ),
          ],
        );
      } catch (e) {
        toast("Ocurrio un error intentelo nuevamente");
        return const SizedBox.shrink();
      }
    }

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (pickedTime != null && pickedTime != _selectedTime) {
        setState(() {
          controller.text =
              "${pickedTime.hour.toString()}:${pickedTime.minute.toString()}";
          _selectedTime = pickedTime;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Generar Horario con IA",
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
              /* CustomTextField(
                textController: controller,
                isObscureText: false,
                hintText: "Tiempo de estudio en minutos",
                type: TextInputType.number,
                width: MediaQuery.sizeOf(context).width,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                    textController: controller,
                    isObscureText: false,
                    hintText: "Hora de inicio estudio",
                    onTap: () async {
                      await _selectTime(context);
                    },
                    type: TextInputType.number,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  CustomTextField(
                    textController: controller,
                    isObscureText: false,
                    hintText: "Hora de final estudio",
                    type: TextInputType.number,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                ],
              ),
              */
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  await generarHorario();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundSecondary,
                ),
                child: Text("Generar Horario",
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              SizedBox(
                height: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Habilita desplazamiento horizontal
                child: SingleChildScrollView(
                    scrollDirection:
                        Axis.vertical, // Habilita desplazamiento vertical
                    child: Consumer<AlumnoBloc>(builder: (context, b, child) {
                      if (b.json != null) {
                        return _buildScheduleTable(b.json!);
                      }
                      return const SizedBox.shrink();
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
