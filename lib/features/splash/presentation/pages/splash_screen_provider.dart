import 'package:cartup/core/injections/injection.dart';
import 'package:cartup/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:cartup/features/splash/presentation/bloc/splash_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen.dart';

class SplashScreenProvider extends StatelessWidget {
  const SplashScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt<SplashBloc>()..add(AppStarted()), child: const SplashScreen());
  }
}
