import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/widget/widget/custom_textfield.dart';
import 'package:agenda_electronica/ui/widget/widget/elevation_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScrenn extends StatelessWidget {
  LoginScrenn({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              textController: controller,
              isObscureText: false,
              hintText: "Usuario",
              type: TextInputType.name,
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomTextField(
              textController: controller,
              isObscureText: true,
              hintText: "Contraseña",
              type: TextInputType.name,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.sp),
              child: ButtonLogin(onPressed: () {}, title: "Iniciar Sesion"),
            )
          ],
        ),
      ),
    );
  }
}
