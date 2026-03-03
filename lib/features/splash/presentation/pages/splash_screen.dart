import 'package:fintech/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/splash_bloc.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is NavigateToOnboarding) {
          context.go(AppRoutes.home);
        } else if (state is NavigateToWelcome) {
          context.go(AppRoutes.home);
        } else if (state is NavigateToHome) {
          context.go(AppRoutes.home);
        }
      },
      child: Scaffold(body: Center(child: FlutterLogo(size: 100))),
    );
  }
}
