import 'package:fintech/features/cart/presentation/bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injections/injection.dart';
import 'core/router/app_router.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<CartBloc>(create: (context) => getIt<CartBloc>()..add(LoadCartProducts()))],
      child: MaterialApp.router(routerConfig: AppRouter.router, theme: ThemeData(useMaterial3: true)),
    );
  }
}
