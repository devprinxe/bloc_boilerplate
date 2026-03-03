import 'package:fintech/core/injections/injection.dart';
import 'package:fintech/features/home/presentation/bloc/home_bloc.dart';
import 'package:fintech/features/home/presentation/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class HomeScreenProvider extends StatelessWidget {
  const HomeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt<HomeBloc>()..add(LoadProducts()), child: const HomeScreen());
  }
}
