import 'package:agenda_electronica/services/globals.dart';
import 'package:agenda_electronica/ui/screens/splash/splash_bloc.dart';
import 'package:agenda_electronica/ui/widget/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repository/auth_repository_intr.dart';
import '../../../domain/repository/local_repository_intr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen._();
  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashBloc(
        authRepositoryInterface: context.read<AuthRepositoryInterface>(),
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      ),
      builder: (_, __) => const SplashScreen._(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class SubscriptionRepositoryInterface {}

class _SplashScreenState extends State<SplashScreen> {
  void _init(BuildContext ctx) async {
    final bloc = ctx.read<SplashBloc>();
    final result = await bloc.validateSession();

    if (result) {
      if (ctx.mounted) {
        /* Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen.init(ctx)),
        ); */
      }
    } else {
      if (ctx.mounted) {
        /*  Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginScreen.init(ctx)),
        ); */
      }
      if (bloc.error.isNotEmpty) {
        if (ctx.mounted) showDialogCustomIOS(ctx, bloc.error, "ALERTA");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initAfterBuild();
  }

  void _initAfterBuild() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      _init(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* Center(
            child: Image.asset(
              'assets/login.png',
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ), */
        ],
      ),
    );
  }
}
