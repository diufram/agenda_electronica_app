import 'package:agenda_electronica/data/datasource/alumno_repository_impl.dart';
import 'package:agenda_electronica/data/datasource/apoderado_repository_impl.dart';
import 'package:agenda_electronica/data/datasource/auth_repository_impl.dart';
import 'package:agenda_electronica/data/datasource/local_repository_impl.dart';
import 'package:agenda_electronica/data/datasource/profesor_repository_impl.dart';
import 'package:agenda_electronica/domain/repository/alumno_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/apoderado_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/auth_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/profesor_repository_intr.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_bloc.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_screen.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_bloc.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_screen.dart';
import 'package:agenda_electronica/ui/screens/login/login_bloc.dart';
import 'package:agenda_electronica/ui/screens/login/login_screnn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize(apiKeyNofitication);
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
        Provider<ApoderadoRepositoryInterface>(
          create: (_) => ApoderadoRepositoryImpl(),
        ),
        ChangeNotifierProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authRepositoryInterface:
                Provider.of<AuthRepositoryInterface>(context, listen: false),
            localRepositoryInterface:
                Provider.of<LocalRepositoryInterface>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<AlumnoBloc>(
          create: (context) => AlumnoBloc(
            alumnoRepositoryInterface:
                Provider.of<AlumnoRepositoryInterface>(context, listen: false),
            localRepositoryInterface:
                Provider.of<LocalRepositoryInterface>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<ProfesorBloc>(
          create: (context) => ProfesorBloc(
            profesorRepositoryInterface:
                Provider.of<ProfesorRepositoryInterface>(context,
                    listen: false),
            localRepositoryInterface:
                Provider.of<LocalRepositoryInterface>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<ApoderadoBloc>(
          create: (context) => ApoderadoBloc(
            apoderadoRepositoryInterface:
                Provider.of<ApoderadoRepositoryInterface>(context,
                    listen: false),
            localRepositoryInterface:
                Provider.of<LocalRepositoryInterface>(context, listen: false),
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
            home: AlumnoScreen.init(context),
          );
        },
      ),
    );
  }
}
