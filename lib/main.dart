import 'package:agenda_electronica/data/datasource/auth_repository_impl.dart';
import 'package:agenda_electronica/data/datasource/local_repository_impl.dart';
import 'package:agenda_electronica/domain/repository/auth_repository_intr.dart';
import 'package:agenda_electronica/domain/repository/local_repository_intr.dart';
import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_screen.dart';

import 'package:agenda_electronica/ui/screens/Profesor/profesor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("bde019e1-c5b5-4852-9135-a829a99244b1");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  print("Este es el Subscription Id");
  print(OneSignalPushSubscription().id);
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

        /*        ChangeNotifierProvider(
            create: (_) => HomeBloc(
                localRepositoryInterface:
                    context.read<LocalRepositoryInterface>())),
        ChangeNotifierProvider(
            create: (_) => QuoteBloc(
                  quoteRepositoryInterface:
                      context.read<QuoteRepositoryInterface>(),
                  localRepositoryInterface:
                      context.read<LocalRepositoryInterface>(),
                )), */
      ],
      child: Builder(builder: (newContext) {
        return ScreenUtilInit(
          designSize: const Size(360, 900),
          minTextAdapt: true,

          //splitScreenMode: true,
          // Use builder only if you need to use library outside ScreenUtilInit context
          builder: (context, child) {
            return MaterialApp(
                builder: FToastBuilder(),
                title: 'Agenda Electronica',
                theme: poppins,
                debugShowCheckedModeBanner: false,
                home: child); //SplashScreen.init(newContext));
          },
          child: AlumnoScreen(),
        );
      }),
    );
  }
}
