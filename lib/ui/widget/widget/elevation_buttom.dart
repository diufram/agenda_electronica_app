import 'package:agenda_electronica/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({super.key, required this.onPressed, required this.title});
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundPrimary,
            //shape: const StadiumBorder(),
            elevation: 20.sp,
            shadowColor: Colors.grey[800],
            minimumSize: Size.fromHeight(60.sp)),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.white),
        ));
  }
}
