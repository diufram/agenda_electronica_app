import 'dart:io';

import 'package:agenda_electronica/services/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

loading(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Platform.isIOS
            ? Center(
                child: CupertinoActivityIndicator(
                radius: 10.sp,
                color: Colors.white,
              ))
            : const Center(
                child: CircularProgressIndicator(
                color: backgroundOptional,
              ));
      });
}
