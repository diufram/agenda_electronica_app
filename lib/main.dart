import 'package:agenda_electronica/data/datasource/alumno_repository_impl.dart';
import 'package:agenda_electronica/data/datasource/auth_repository_impl.dart';
import 'package:agenda_electronica/data/datasource/local_repository_impl.dart';
import 'package:agenda_electronica/data/datasource/profesor_repository_impl.dart';
import 'package:agenda_electronica/domain/repository/alumno_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/auth_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/profesor_repository_intr.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_bloc.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_screen.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_screen.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialización de OneSignal
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("bde019e1-c5b5-4852-9135-a829a99244b1");
  OneSignal.Notifications.requestPermission(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepositoryInterface>(
          create: (_) => AuthRepositoryImpl(),
        ),
        Provider<LocalRepositoryInterface>(
          create: (_) => LocalRepositoryImpl(),
        ),
        Provider<AlumnoRepositoryInterface>(
          create: (_) => AlumnoRepositoryImpl(),
        ),
        Provider<ProfesorRepositoryInterface>(
          create: (_) => ProfesorRepositoryImpl(),
        ),
        ChangeNotifierProvider<AlumnoBloc>(
          create: (context) => AlumnoBloc(
            alumnoRepositoryInterface:
                Provider.of<AlumnoRepositoryInterface>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<ProfesorBloc>(
          create: (context) => ProfesorBloc(
            profesorRepositoryInterface:
                Provider.of<ProfesorRepositoryInterface>(context,
                    listen: false),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 900),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
              builder: FToastBuilder(),
              title: 'Agenda Electronica',
              theme: poppins,
              debugShowCheckedModeBanner: false,
              home:
                  ApoderadoScreen() //AlumnoScreen.init(context), // Iniciar la pantalla principal aquí
              );
        },
      ),
    );
  }
}
