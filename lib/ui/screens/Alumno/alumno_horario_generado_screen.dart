import 'dart:convert';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AlumnoHorarioGeneradoScreen extends StatelessWidget {
  AlumnoHorarioGeneradoScreen({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlumnoBloc>();

    Widget _buildScheduleTable(String jsonString) {
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
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        title: Text(
          "Horario Gen IA",
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
          child: FutureBuilder<String>(
            future: bloc.getHorarioGenerado(),
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
                final data = snapshot.data!;

                return SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal, // Habilita desplazamiento horizontal
                    child: SingleChildScrollView(
                        scrollDirection:
                            Axis.vertical, // Habilita desplazamiento vertical
                        child: _buildScheduleTable(data)));
              } else {
                // Si no hay datos
                return const Center(
                    child: Text("No se Asignaron Materias Aun"));
              }
            },
          ),
        ),
      ),
    );
  }
}
