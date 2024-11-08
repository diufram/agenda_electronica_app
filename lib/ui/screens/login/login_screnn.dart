import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/Alumno/alumno_screen.dart';
import 'package:agenda_electronica/ui/screens/Apoderado/apoderado_screen.dart';
import 'package:agenda_electronica/ui/screens/Profesor/profesor_screen.dart';
import 'package:agenda_electronica/ui/screens/login/login_bloc.dart';
import 'package:agenda_electronica/ui/widget/widget/custom_textfield.dart';
import 'package:agenda_electronica/ui/widget/widget/elevation_buttom.dart';
import 'package:agenda_electronica/ui/widget/widget/loading_modal.dart';
import 'package:agenda_electronica/ui/widget/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScrenn extends StatelessWidget {
  const LoginScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    Future<void> login() async {
      final response = await bloc.login();
      loading(context);
      if (response == 1) {
        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ProfesorScreen.init(context)),
            (Route<dynamic> route) => false, // Aquí defines el predicado
          );
        }
      } else if (response == 2) {
        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ApoderadoScreen()),
            (Route<dynamic> route) => false, // Aquí defines el predicado
          );
        }
      } else if (response == 3) {
        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AlumnoScreen.init(context)),
            (Route<dynamic> route) => false, // Aquí defines el predicado
          );
        }
      }

      if (response == 0) {
        if (context.mounted) Navigator.pop(context);
        toast("No se encontro el Usuario");
      }
    }

    return Scaffold(
      backgroundColor: backgroundSecondary,
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Icono.png',
              width: 200.sp,
              height: 200.sp,
            ),
            Center(
              child: Text(
                "Iniciar Sesion",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            CustomTextField(
              textController: bloc.ciController,
              isObscureText: false,
              hintText: "Carnet de Identidad",
              type: TextInputType.number,
              width: MediaQuery.sizeOf(context).width * 0.97,
            ),
            SizedBox(
              height: 10.sp,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.sp),
              child: ButtonLogin(
                  onPressed: () async {
                    await login();
                  },
                  title: "Iniciar Sesion"),
            )
          ],
        ),
      ),
    );
  }
}
