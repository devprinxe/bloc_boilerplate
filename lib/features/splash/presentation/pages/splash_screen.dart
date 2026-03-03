import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/splash_bloc.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is NavigateToOnboarding) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigate to onboarding')));
        }
      },
      child: Scaffold(body: Center(child: FlutterLogo(size: 100))),
    );
  }
}
